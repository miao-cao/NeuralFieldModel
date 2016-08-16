function phiBasisFunctions =  CreatePhiBasisFunctions(SpaceMin, SpaceMax, NPoints, nx, mu_phi, sigma_phi)
%%
% parameter list:
% parameters used to create a  2-D cortical surface
% SpaceMin - Edge of surface on the negative side
% SpaceMax - Edge of surface on the positive side
% NPoints - number of points along each dimension
% nx - number of states
% mu_phi - centre of Gaussian basis function for phi
% sigma_phi - sigma of Gaussian basis function for phi
%%
numRow = sqrt(nx); % number of gaussians for each colomn
numCol = nx / numRow; % number of columns

widthSpace = SpaceMax - SpaceMin;
widthCentre = widthSpace / (numCol*2);

% If mu_phi is not pre-defined, create phi with centres of Gaussian basis
% function uniformly distributed.
if isempty(mu_phi) || any(mu_phi) % if mu_phi is empty or only zeros
    mu_phi = zeros(nx, 2); % centres of each phi (gaussian)
    for m = 1 : numRow
        for n = 1 : numCol
            mu_phi(n + numCol*(m-1), :) = [(SpaceMin - widthCentre + m*widthCentre*2) (SpaceMin - widthCentre + n*widthCentre*2)];
        end
    end
end

covMat_phi = [sigma_phi 0; 0 sigma_phi];
%%
phiBasisFunctions = zeros(NPoints, NPoints, nx);
for n = 1 : nx
    phiBasisFunctions(:,:, n) = Define2DGaussian_AnisotropicKernel(mu_phi(n, 1), mu_phi(n, 2), covMat_phi, NPoints, SpaceMin, SpaceMax);
end
end