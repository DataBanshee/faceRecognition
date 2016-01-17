% faceFeat: matrice des individus par descripteur
% rotMatrix: matrice de rotation obtenue sans réduction de dimension
% nbLig: nombre de lignes de l'image originale
% nbCol: nombre de colonnes de l'image originale
%
function rebuildImage(faceFeat, rotMatrix, nbLig, nbCol )

%% Locales
% cte
nbFaceIter = 2 ; % nb de visages affichés en même temps
nbCompIter = 1 ; % pas des composantes principales à afficher
nbPcaIter = 25; % nb total de composantes principales à afficher

% var
[nbImg, nbFeat] = size(faceFeat);

%% Calcul de l'image moyenne
% Calculate the mean face
% meanfacevec = mean(facevec,2);
% figure; imshow( reshape(meanfacevec,[nbLig, nbCol])); colormap(gray)
% [rotMatrix,acpQualityInd,eigVal,eigVect,moy,sigm] = acpDefine(facevec',inf);

meanFaceFeat = mean(faceFeat,1);
meanFaceFeat_img = uint8(reshape(meanFaceFeat,[nbLig, nbCol]));

% Affichage de l'image moyenne
% figure; imshow( meanFaceFeat_img  ); colormap(gray)
% title('Image moyenne')

%% Affichage et traitements
numImgDisp = 1:nbImg;
figure;
for iIter = 1 : numel(numImgDisp)/nbFaceIter
    
    % Affichage de l'image originale et de l'image moyenne
    for iFace = 1 : nbFaceIter
        
        %figure
        subplot(2,nbFaceIter,iFace)
        %Plot the face
        curFace = faceFeat(numImgDisp(iFace+(iIter-1)*nbFaceIter),:);
        
        tmp = uint8(reshape(curFace, [nbLig nbCol]));
        imshow(tmp);
        
        title('Image Originale')
        
        %The mean vector
        subplot(2,nbFaceIter,iFace+nbFaceIter)
        imshow(meanFaceFeat_img);
        
        title('Image moyenne')
        
    end
    colormap(gray);
    pause
    
    for iPca = 1 : nbPcaIter
        for iFace = 1 : nbFaceIter
            curFace = faceFeat(numImgDisp(iFace+(iIter-1)*nbFaceIter),:);
            tmpFaceFeatProj = acpProject(curFace - meanFaceFeat, rotMatrix(:,1:nbCompIter*iPca));
            
            tmpFaceFeat = acpReProject(tmpFaceFeatProj,rotMatrix(:,1:nbCompIter*iPca));
            tmp = uint8(reshape(tmpFaceFeat+meanFaceFeat, [nbLig nbCol]));
            
            %
            subplot(2,nbFaceIter,iFace+nbFaceIter)
            imshow(tmp)
            title( sprintf('reconstruction %i comp.', nbCompIter*iPca))
            
        end
        pause
    end
end;


end