
% Question 6
clear all;
load('attFacesDatabase.mat');
% testFacesfeat : Vecteur contenant 120 images de 28*23
% redimensionnées en vecteur 1*644
% testFacesLabel : le vecteur de label correspondant aux images

% trainFacesfeat : Vecteur contenant 280 images d'apprentissage de 28*23
% redimensionnées en vecteur 1*644
% trainFacesLabel : le vecteur de label correspondant aux images


figure(6)
subplot(2,2,1);
imshow(reshape(trainFacesFeat(1,:),nbLig,nbCol),[]);
title('Image 1');
subplot(2,2,2);
imshow(reshape(trainFacesFeat(2,:),nbLig,nbCol),[]);
title('Image 2');

subplot(2,2,3),
imshow(reshape(trainFacesFeat(3,:),nbLig,nbCol),[]);
title('Image 3');
subplot(2,2,4);
imshow(reshape(trainFacesFeat(4,:),nbLig,nbCol),[]);
title('Image 4');

% Image moyenne de la base d'apprentissage
ImageMoyenne = mean(trainFacesFeat,1);
m = ImageMoyenne;
ImageMoyenne = reshape(ImageMoyenne,nbLig,nbCol);
figure(4)
imshow(ImageMoyenne,[]);

AverageFaceFeat = trainFacesFeat - repmat(m,size(trainFacesFeat,1),1);

nbPix = nbLig*nbCol;

[rotMatrix,acpQualityInd,eigVal,eigVect,moy,sigm] = acpDefine(AverageFaceFeat,nbPix);

Dispersion = eigVal;
Inertie = eigVal/sum(eigVal)*100;

for i=1:nbPix
    EigenFaces{i} = reshape(eigVect(:,i),nbLig,nbCol);
end

% The eigenvalues associated with each eigenface represent how much the
% images in the training set vary from the mean image in that direction
figure(5)
for i=1:43
    subplot(8,6,i);
    h = imshow(EigenFaces{i},[],'InitialMag',100, 'Border','tight');
    title(num2str(i))
    set(h, 'ButtonDownFcn',{@callback,i,EigenFaces})
end




% Question 4
[newRotMatrix,newAcpQualityInd,newEigVal,newEigVect,newMoy,newSigm] = acpDefine(AverageFaceFeat,20);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 5
% @testFaceFeat : Les images tests normalisées projetées sur l'espace des eigenFaces
% @trainFaceFeat : Les images d'apprentissages projetées sur l'espace des
% eigenFaces
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Shuffling the Test Images Randomly
%TestAverageFaceFeat = AverageFaceFeat(randperm(size(AverageFaceFeat,1)),:);
testAverageFaceFeat = testFacesFeat-repmat(mean(testFacesFeat),size(testFacesFeat,1),1);
testFaceFeat = acpProject(testAverageFaceFeat,newRotMatrix);
testFaceFeat = acpReProject(testFaceFeat,newRotMatrix);

%TrainAverageFaceFeat =

trainFaceFeat = acpProject(AverageFaceFeat,newRotMatrix);
trainFaceFeat = acpReProject(trainFaceFeat,newRotMatrix);




[featLearnRed, labelLearnRed] = knnCondensed (1, trainFaceFeat, trainFacesLabels);
labelTest = knnClassify (1, featLearnRed, labelLearnRed, testFaceFeat);

diff = find((labelTest-testFacesLabels)~=0);
err = (numel(diff)/size(testFacesLabels,1))*100;

%278 composantes gardées ==> 5% d'erreur
%10 composantes gardées ==> 15% d'erreur
%50 composantes gardées ==> 6.67%
%20 composantes gardées ==> 10%

