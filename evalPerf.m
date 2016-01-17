% Fonction d'évaluation des performances d'un classifieur
%
% [matConf,probClassif,probErreur]=param_perf(restest);
%
% ENTREES
%   actual      - vecteur colonne donnant la classe réelle d'appartenance
%   prediction  - vecteur colonne donnant la classe prédite d'appartenance
%
% SORTIES
%   matConf     - matrice de confusion
%   probClassif - vecteur contenant la probabilité de bonne classification pour chaque classe
%   probErreur  - vecteur contenant la probabilité moyenne d'erreur pour chaque classe
%
% Auteur: 
% modif : GLC 2011
% -------------------------------------------------------------------------

function [matConf,probClassif,probErreur] = evalPerf(actual, prediction)

% Locales
classe = unique(actual);
nbClass = numel( classe );

% Calcul de la matrice de confusion
matConf = zeros(nbClass,nbClass);
for iClass = 1 : nbClass
    for iClass2 = 1 : nbClass
        matConf(iClass,iClass2) = sum((actual==classe(iClass))&(prediction==classe(iClass2)));
    end
end	

% Calcul de la matrice de confusion normalisée
vect_nbre_vect = sum(matConf');
matr_nbre_vect = repmat(vect_nbre_vect',1,nbClass);
matConfNorm = matConf./matr_nbre_vect;

% proba de bonne classif par classe
probClassif = diag(matConfNorm)';

% proba d'erreur par classe
matr_prob_erreur=zeros(2,nbClass); 
for k=1:nbClass
    matr_prob_erreur(1,k) = sum(matConfNorm(k,:))-matConfNorm(k,k) ;
    matr_prob_erreur(2,k) = (sum(matConfNorm(:,k))-matConfNorm(k,k))/(nbClass-1);
end
probErreur = mean(matr_prob_erreur); 


end