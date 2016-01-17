% Analyse en composantes principales
%
% [rotMatrix,acpQualityInd,eigVal,eigVect,moy,sigm] = acpDefine(feat,nbComp);
%
% ENTREES
%   feat          - matrice des vecteurs a projeter (nbVect lignes, nbFeat colonnes)
%   nbComp        - si superieur a 1, represente la dimension de l'espace de projection
%                   si inferieur a 1, represente le pourcentage de l'inertie conserv�e
%
% SORTIES
%   rotMatrix     - matrice des projection de l'espace des descripteurs vers les composantes principales
%                   chaque colonne repr�sente une composante principale
%   acpQualityInd - indice de qualit� de l'ACP (%age de la dispersion conserv�e)
%   eigVal        - valeurs propres
%   eigVect       - vecteurs propres
%   moy           - moyenne
%   sigm          - matrice de covariance
%
% EXEMPLE
%   feat = randn(1000,3);
%   [rotMatrix,acpQualityInd,eigVal,eigVect,moy,sigm] = acpDefine(feat,2);
%   featProj = acpProject(feat,rotMatrix);
%   figure;plot3(feat(:,1),feat(:,2),feat(:,3),'xr')
%   grid;xlabel('x');ylabel('y');ylabel('z')
%   title('Vecteurs dans l''espace initial')
%   figure;plot(featProj(:,1),featProj(:,2),'xr')
%   grid;xlabel('p_1');ylabel('p_2')
%   title('Vecteurs projetes par ACP')
%
% Auteur: 
% modif : GLC 2011
% -------------------------------------------------------------------------

function [rotMatrix,acpQualityInd,eigVal,eigVect,moy,sigm] = acpDefine(feat,nbComp) 

% Estimation de la moyenne
moy = mean(feat);

% Estimation de la matrice de covariance
sigm = cov(feat);

% D�composition en val prop
[eigVect,eigVal] = eig(sigm);

eigVal = diag(eigVal);

% tri des valeurs propres suivant l'ordre d�croissant 
[eigVal,idx]=sort(eigVal,'descend');
eigVect = eigVect(:,idx);

% pourcentage de dispersion conserv�e en fonction du nombre d'axes principaux conserv�s
eigValc = cumsum(eigVal);
acpQualityInd = eigValc/sum(eigVal);

% Choix du nombre de composantes
if nbComp < 1
    % nombre d'axes principaux � conserver pour conserver 'seuil' % d'�nergie
    idxc = find(acpQualityInd >= nbComp); 
    nbComp = idxc(1);
end

% sorties
if ~isfinite(nbComp)
    nbComp = size(eigVect,1);
end
rotMatrix = eigVect(:,1:nbComp);
acpQualityInd = acpQualityInd(nbComp);