% Projection de l'analyse en composantes principales
%
% feat_acp = acpProject(feat,rotMatrix)
%
% ENTREES
%   feat      - matrice des vecteurs de descripteurs a projeter (nbVect lignes, nbFeat colonnes)
%   rotMatrix - matrice des projection de l'espace des descripteurs vers les composantes principales
%
% SORTIES
%   featProj  - matrice des vecteurs de descripteurs projetés (nbVect lignes, nbComp colonnes)
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
function featProj = acpProject(feat,rotMatrix)

% projection
featProj = (rotMatrix'*feat')';

end
