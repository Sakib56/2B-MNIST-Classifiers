function [Ypreds, Ms, Covs] = run_gaussian_classifiers(Xtrain, Ytrain, Xtest, epsilon)
% Input:
%   Xtrain : M-by-D training data matrix (double)
%   Ytrain : M-by-1 label vector for Xtrain (uint8)
%   Xtest  : N-by-D test data matrix (double)
%   epsilon : A scalar variable (double) for covariance regularisation
% Output:
%  Ypreds : N-by-1 matrix (uint8) of predicted labels for Xtest
%  Ms     : K-by-D matrix (double) of mean vectors
%  Covs   : K-by-D-by-D 3D array (double) of covariance matrices

%YourCode - Bayes classification with multivariate Gaussian distributions.

    N = size(Xtest,1);
    D = size(Xtrain,2);
    K = size(unique(Ytrain),1);
    Ms = zeros(K,D);
    Covs = zeros(K,D,D);
    likelihood = zeros(N, K);

    for k = 1:K
        % calculate mean matrix for each class
        num = Xtrain(Ytrain == k-1, :);
        mean = (sum(num,1)./size(num,1));
        Ms(k,:) = mean;

        % calculate covariance matrix for each class
        L = length(num);
        X = bsxfun(@minus, num, mean);
        covariance = 1/(L-1) * (X' * X);
        Covs(k,:,:) = covariance + eye(D) * epsilon;
        
        % calculate post probs (bayes' rule) using logs (since without values would be too small)
        delta = -repmat(Ms(k,:)', 1, N) + Xtest';
        log_matrix = -delta' / squeeze(Covs(k,:,:)) * delta - 0.5 * logdet(squeeze(Covs(k,:,:)));
        likelihood(:,k) =  diag(0.5*log_matrix);
        % assumption that there is a uniform distribution, so no need to get prior for post calculation
    end

    % choose the most probable class out of the options
    [~, Ypreds] = max(likelihood, [], 2);
    Ypreds = Ypreds-1; %since 0 is a class
end
