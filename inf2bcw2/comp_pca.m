function [EVecs, EVals] = comp_pca(X)
% Input:
%   X:  N x D matrix (double)
% Output:
%   EVecs: D-by-D matrix (double) contains all eigenvectors as columns
%       NB: follow the Task 1.3 specifications on eigenvectors.
%   EVals:
%       Eigenvalues in descending order, D x 1 vector (double)
%   (Note that the i-th columns of Evecs should corresponds to the i-th element in EVals)

    N = length(X);
    x_mean = double(sum(X))./size(X, 1);
    X = bsxfun(@minus, X, x_mean);
    covariance = 1/(N-1) * (X' * X);    %caluclating the covariance matrix

    [PC, V] = eig(covariance);  %getting the eigenvectors and eigenvalues of the covariance matrix

    V = diag(V); %diagonalizing the eigenvalues for..

    [~, ridx] = sort(V, 1, 'descend');  %sorting in the correct format...
    % since diagaonals of the pca matrix should be eigenvalues
    
    EVecs = PC(:, ridx);
    EVals = V(ridx);

    for i=1:length(EVecs)   %makes sure that none of the first entries of the matrix is negative
        if EVecs(1, i)<0
            EVecs(:,i) = (-1)*EVecs(:,i); %if matrix is negative then, *-1 to fix this
        end
    end
end

