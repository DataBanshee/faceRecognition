% Classement par le k-means
%
% [label,centroid] = kmeansClass(feat,nbCluster)
%
% ENTREES
%   feat          - matrice des descripteurs  (nbVect lignes, nbFeat colonnes)
%   centroid      - coordonnees des centres de classes
%
% SORTIES
%   label         - vecteur des classes d'appartenance
%
% EXEMPLE
%
% Auteur: 
% modif : GLC 2011
% -------------------------------------------------------------------------
function label = kmeansClass(feat,centroid)

% locales
nbPix = size(feat,1);
nbCluster = size(centroid,1);

% initialisation de la matrice de distances
distance=zeros(nbPix,nbCluster);

% calcul de la distance aux centroids
for c = 1 : nbCluster
    distance(:,c) = sum((feat-(ones(nbPix,1)*centroid(c,:))).^2,2);
end

% Attribution de la classe
[mini,label] = min(distance,[],2);


end