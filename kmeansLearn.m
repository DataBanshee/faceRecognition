% Apprentissage non supervisé par le k-means
%
% [label,centroid] = kmeansLearn(feat,nbCluster)
%
% ENTREES
%   feat          - matrice des descripteurs  (nbVect lignes, nbFeat colonnes)
%   nbCluster     - nombre de classes à considérer
%
% SORTIES
%   label         - vecteur des classes d'appartenance
%   centroid      - coordonnees des centres de classes
%
% EXEMPLE
%
% Auteur: 
% modif : GLC 2011
% -------------------------------------------------------------------------

function [label,centroid] = kmeansLearn(feat,nbCluster)

kmean_ok=0;
ntry = 0;
while kmean_ok == 0
    try
        [label,centroid] = kmeans(feat,nbCluster,'start','sample');
        kmean_ok = 1;
        ntry = ntry+1;
    catch
        kmean_ok = 0;
    end
end

% s = fprintf ('ntry = %3d\n',ntry);

end