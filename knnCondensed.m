% Apprentissage par le k-NN condensé
%
% labelTest = knnCondensed (k, featLearn, labelLearn)
%
% ENTREES
%   k          - nombre de voisins
%   featLearn  - matrice des descripteurs d'apprentissage
%   labelLearn - vecteur colonne donnant la classe d'appartenance
%
% SORTIES
%   featLearnRed  - matrice réduite des descripteurs d'apprentissage 
%   labelLearnRed - vecteur colonne réduit donnant la classe d'appartenance
%
% Auteur: 
% modif : GLC 2011
% -------------------------------------------------------------------------
function [featLearnRed, labelLearnRed] = knnCondensed(k,featLearn,labelLearn)

% Init
nbVectLearn = max(1,k);
featLearnRed = featLearn(1:nbVectLearn,:);
labelLearnRed = labelLearn(1:nbVectLearn);
change = true;

% traitements
while (change == true)
    change = false;
    labelCur = knnClassify(k, featLearnRed, labelLearnRed, featLearn);
    
    subNonOk = find(labelCur ~= labelLearn);
    if numel(subNonOk) > 0
        featLearnRed(nbVectLearn+1,:) = featLearn(subNonOk(1),:);
        labelLearnRed(nbVectLearn+1) = labelLearn(subNonOk(1));
        nbVectLearn = nbVectLearn+1;
        change = true;
    end
end

