unzip('14. faceDatabase.zip');
addpath('faceDatabase');
ImageData = ReadImgs('faceDatabase','*.jpg');

% Affichage des images RGB
% Cliquer pour agrandir
    figure(1)
    for i=1:43
        subplot(8,6,i);
        h = imshow(ImageData{i}, 'InitialMag',100, 'Border','tight');
        title(num2str(i))
        set(h, 'ButtonDownFcn',{@callback,i,ImageData})
    end
    
    % Transformer en niveau de gris
    for i=1:43
        GrayImageData{i} = rgb2gray(ImageData{i});
    end
    
% Affichage des images Gray
% Cliquer pour agrandir
    figure(3)
    for i=1:43
        subplot(8,6,i);
        h = imshow(GrayImageData{i}, 'InitialMag',100, 'Border','tight');
        title(num2str(i))
        set(h, 'ButtonDownFcn',{@callback,i,GrayImageData})
    end
    
 % Redimensionnement de 10 fois
 for i=1:43
    ResizedGrayImageData{i} = imresize(GrayImageData{i},0.1);
 end
 
 % Creer la matrice des descripteurs
[nbLig,nbCol] = size(ResizedGrayImageData{1});

nbPix = nbLig*nbCol;
faceFeat = zeros(43,nbPix);

for i=1:43
    faceFeat(i,:) = reshape(ResizedGrayImageData{i},1,nbPix);
end

% ACP

% [rotMatrix,acpQualityInd,eigVal,eigVect,moy,sigm] = acpDefine(faceFeat,nbPix);
% 
% Dispersion = eigVal;
% Inertie = eigVal/sum(eigVal)*100;

%[rotMatrix,acpQualityInd,eigVal,eigVect,moy,sigm] = acpDefine(faceFeat,42);
 
% Image Moyenne : Centre de Gravit� du nuage des individus?
ImageMoyenne = mean(faceFeat,1);
m = ImageMoyenne;
ImageMoyenne = reshape(ImageMoyenne,nbLig,nbCol);
figure(4)
imshow(ImageMoyenne,[]);

AverageFaceFeat = faceFeat - repmat(m,43,1);

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
    
 % Cette fonction permet de projeter l'image sur l espace des composantes principales
 % puis a partir de cette projection, en inversant le calcul nous pouvons
 % reconstruire l'image en utilisant un nombre restreint de vecteurs de CP
 
 % Only a fraction of the eigenfaces is needed to reprensent the majority
 % if the faces
 
 rebuildImage(faceFeat, rotMatrix, nbLig, nbCol );
 
 % Question 4
 [newRotMatrix,newAcpQualityInd,newEigVal,newEigVect,newMoy,newSigm] = acpDefine(AverageFaceFeat,42);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 5
% @testFaceFeat : Les images tests normalis�es projet�es sur l'espace des eigenFaces
% @trainFaceFeat : Les images d'apprentissages projet�es sur l'espace des
% eigenFaces
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
Eigenfaces = faceFeat*newRotMatrix;  
 

%   % Shuffling the Test Images Randomly
Permutation = randperm(size(AverageFaceFeat,1));
TestAverageFaceFeat = AverageFaceFeat(Permutation,:);

ProjectingTraining = Eigenfaces'*AverageFaceFeat;
ProjectingTesting = Eigenfaces'*AverageFaceFeat; %TestAverageFaceFeat


  FaceRecognitionImage = similarityScore(ProjectingTesting,ProjectingTraining);
  
  euclide_dist = [ ];
for i=1 : size(Eigenfaces,2)
    temp = (norm(ProjectingTesting(1,:)-ProjectingTraining(i,:)))^2;
    euclide_dist = [euclide_dist 1/(1+temp)];
end
[euclide_dist_min recognized_index] = max(euclide_dist);
  
  figure(6)
  subplot(2,2,1);
  imshow(reshape(AverageFaceFeat(21,:)+m,nbLig,nbCol),[]);
  title('Image de test en Entr�e');
  subplot(2,2,2);
  imshow(reshape(AverageFaceFeat(FaceRecognitionImage(21),:)+m,nbLig,nbCol),[]);
  title('Image retrouv�e dans la base de donn�e');
  
  subplot(2,2,3),
  imshow(reshape(AverageFaceFeat(15,:)+m,nbLig,nbCol),[]);
  title('Image de test en Entr�e');
  subplot(2,2,4);
  imshow(reshape(AverageFaceFeat(FaceRecognitionImage(15),:)+m,nbLig,nbCol),[]);
  title('Image retrouv�e dans la base de donn�e');
  
  
  %   testFaceFeat = acpProject(TestAverageFaceFeat,newRotMatrix);
  %   testFaceFeat = acpReProject(testFaceFeat,newRotMatrix);
  %   %testFaceFeat = EigenFaces'*TestAverageFaceFeat;
  
  %trainFaceFeat = Image_Projection(AverageFaceFeat,EigenFaces);
  %testFaceFeat = Image_Projection(TestAverageFaceFeat,EigenFaces);
 
 
 

