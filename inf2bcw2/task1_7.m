%
%
function Dmap = task1_7(MAT_ClusterCentres, MAT_M, MAT_evecs, MAT_evals, posVec, nbins)
% Input:
%  MAT_ClusterCentres: MAT filename of cluster centre matrix
%  MAT_M     : MAT filename of mean vectors of (K+1)-by-D, where K is
%              the number of classes (which is 10 for the MNIST data)
%  MAT_evecs : MAT filename of eigenvector matrix of D-by-D
%  MAT_evals : MAT filename of eigenvalue vector of D-by-1
%  posVec    : 1-by-D vector (double) to specify the position of the plane
%  nbins     : scalar (integer) to specify the number of bins for each PCA axis
% Output
%  Dmap  : nbins-by-nbins matrix (uint8) - each element represents
%	   the cluster number that the point belongs to.

    % load data via saved matrices
    load(MAT_ClusterCentres, 'C');
    load(MAT_M, 'M');
    load(MAT_evecs, 'EVecs');
    load(MAT_evals, 'EVals');

    % get standard devations from EVals (using the 2 most significant eigenvalues)
    StDev1 = sqrt(EVals(1)); %StDev for X axis
    StDev2 = sqrt(EVals(2)); %StDev for Y axis

    % get means from EVecs (using the 2 most significant eigenvectors and position vector)
    mean_vector = (M(11,:) - posVec) * EVecs(:,1:2);
    mean1 = mean_vector(1); %mean for X axis
    mean2 = mean_vector(2); %mean for Y axis

    % set 'zoom level' to Mean(+-)5*StDev
    Xplot = linspace(mean1-5*StDev1, mean1+5*StDev1, nbins);
    Yplot = linspace(mean2-5*StDev2, mean2+5*StDev2, nbins);

    %create a grid by with the corrosponding zoom level
    [Xv, Yv] = meshgrid(Xplot, Yplot);

    %creating the space's cells, nbins by nbins
    gridX = [Xv(:), Yv(:)];
    Zplot = zeros(nbins*nbins, length(posVec));
    Zplot(:,1:2) = gridX;

    V = Zplot/EVecs + posVec; %projection down into 2D (solving for x)

    % performing k means and classify and output onto dmap
    for i = 1:length(gridX)
        vector = V(i,:);
        dists = sum(bsxfun(@minus, C, vector).^2, 2)';
        [~, I] = min(dists);
        Dmap(i,1) = I(1,1);
    end
    
    %show the 2D projection, dmap
    Dmap = reshape(Dmap,nbins,nbins);
    [~,h] = contourf(Xplot(:), Yplot(:), Dmap);
    set(h,'LineColor','none');

    k = size(C,1);
    %save the plots and mats
    %save(sprintf('task1_7_dmap_%d.mat',k),'Dmap');
    %print('-bestfit', sprintf('task1_7_imgs_%d.pdf',k), '-dpdf');
end
