% Partition aleatoire du vecteur [1:N] en deux sous-vecteurs
%
% [idx1,idx2] = partition(N,p1);
%
% ENTREES
%   N    - longueur totale du vecteur des indices initial
%   p1   - rapport entre la longueur du premier vecteur et 
%          la longueur du vecteur initial
%
% SORTIES
%   idxn - les vecteurs d'indices generes
%
% REMARQUE: p2=1-p1;
%
% EXEMPLE
%   [idx1,idx2]=partition(10,.5)
%
% Auteur: Arnaud MARTIN 03/2005
% modif : GLC 2011
% -------------------------------------------------------------------------

function [idx1,idx2] = partition(N,p1)

tab_indice = randperm(N);

idx1 = tab_indice(1:fix(N*p1));
idx2 = tab_indice(fix(N*p1)+1:N);


% Remarque : fix tronque, round arrondirait à l'entier supérieur

end