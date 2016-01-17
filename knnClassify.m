% Classement par le classifieur k-NN
%
% labelTest = knnClassify (k, featLearn, labelLearn, featTest)
%
% ENTREES
%   k          - nombre de voisins
%   featLearn  - matrice des descripteurs d'apprentissage
%   labelLearn - vecteur colonne donnant la classe d'appartenance
%   featTest   - matrice des descripteurs à tester
%
% SORTIES
%   labelTest  - vecteur colonne donnant la classe prédite d'appartenance
%
% Auteur: 
% modif : GLC 2011
% -------------------------------------------------------------------------

function labelTest = knnClassify (k, featLearn, labelLearn, featTest)

%% locales
nbVectLearn = size(featLearn,1); 
nbVectTest = size(featTest,1); 
nbClass = numel(unique(labelLearn));
% nbClass = sort(unique(labelLearn));


%% initialisation
labelTest = zeros(nbVectTest,1);

%% traitements
if ( k == 1 ) % 1-NN
    for iVect = 1 : nbVectTest
        distance = sum((featLearn-(ones(nbVectLearn,1)*featTest(iVect,:))).^2,2);
        [sortdist,idx] = sort(distance);
        labelTest(iVect) = labelLearn(idx(1));
    end
    
else % k-NN
    hbins = 1:nbClass;
    for iVect = 1 : nbVectTest
        distance = sum((featLearn-(ones(nbVectLearn,1)*featTest(iVect,:))).^2,2);
        [sortdist,idx] = sort(distance);

        tmp = labelLearn(idx(1:k));
        [h,bin] = hist(tmp,hbins);
        [maxcl,k] = max(h);
        labelTest(iVect) = bin(k);
    end
end


end