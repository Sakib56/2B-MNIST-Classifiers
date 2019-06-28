%
%
function Dmap = task2_2(Xtrain, Ytrain, k, MAT_evecs, MAT_evals, posVec, nbins)
% Input:
%  X   : M-by-D data matrix (double)
%  k   : scalar (integer) - the number of nearest neighbours
%  MAT_evecs : MAT filename of eigenvector matrix of D-by-D
%  MAT_evals : MAT filename of eigenvalue vector of D-by-1
%  posVec    : 1-by-D vector (double) to specity the position of the plane
%  nbins     : scalar (integer) - the number of bins for each PCA axis
% Output:
%  Dmap  : nbins-by-nbins matrix (uint8) - each element represents
%	   the cluster number that the point belongs to.

    % load data via saved matrices
    load(MAT_evecs, 'EVecs');
    load(MAT_evals, 'EVals');

    % get standard devations from EVals (using the 2 most significant eigenvalues)
    StDev1 = sqrt(EVals(1)); %StDev for X axis
    StDev2 = sqrt(EVals(2)); %StDev for Y axis

    mean_vector = (double(Xtrain(11,:)) - posVec) * EVecs(:,1:2);
    mean1 = mean_vector(1,1); %mean for X axis
    mean2 = mean_vector(1,2); %mean for Y axis

    % set 'zoom level' to Mean(+-)5*StDev
    Xplot = linspace(mean1-5*StDev1, mean1+5*StDev1, nbins);
    Yplot = linspace(mean2-5*StDev2, mean2+5*StDev2, nbins);

    %create a grid by with the corrosponding zoom level
    [Xv, Yv] = meshgrid(Xplot, Yplot);
    
    %projection down into 2D (solving for x)
    V = [Xv(:), Yv(:)]*EVecs(:,1:2)' + posVec;

    % running knn and assigning values into Dmap
    Dmap = run_knn_classifier(Xtrain, Ytrain, V, k);
    
    %show the 2D projection, dmap
    Dmap = reshape(Dmap,nbins,nbins);
    [~,h] = contourf(Xplot(:), Yplot(:), Dmap);
    set(h,'LineColor','none');
    
    %save the plots and mats
    %save(sprintf('task2_2_dmap_%d.mat',k),'Dmap');
    %print('-bestfit', sprintf('task2_2_imgs_%d.pdf',k), '-dpdf')
end
