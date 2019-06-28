function [Ypreds, MMs, MCovs] = run_mgcs(Xtrain, Ytrain, Xtest, epsilon, L)
% Input:
%   Xtrain : M-by-D training data matrix (double)
%   Ytrain : M-by-1 label vector for Xtrain (uint8)
%   Xtest  : N-by-D test data matrix (double)
%   epsilon : A scalar parameter for regularisation (double)
%   L      : scalar (integer) of the number of Gaussian distributions per class
% Output:
%  Ypreds : N-by-1 matrix of predicted labels for Xtest (integer)
%  MMs     : (L*K)-by-D matrix of mean vectors (double)
%  MCovs   : (L*K)-by-D-by-D 3D array of covariance matrices (double)

K = length(unique(Ytrain));
D = size(Xtrain, 2);
class_Ms = zeros(L, D);
class_Covs = zeros(L, D, D);
MMs = zeros(L*K,D);
MCovs = zeros(L*K,D,D);
likelihood = zeros(size(Xtest,1), K);

for k=1:K
    % for each class of number
    X = Xtrain(Ytrain == k-1, :); 
    [C, ~, ~] = my_kMeansClustering(X, L, X(1:L,:)); % run knn on just that class to get 'styles' of that class
    
    N = length(X);
    for i=1:N
        dist = sum(bsxfun(@minus, X(i,:), C).^2, 2)'; %use the minimum distance neighbour as it's label
    end
    [~, Y] = min(dist);
    
    % then for eahc of those subclasses ('styles' for a classs)
    for l=1:L
        num = X(Y==l, :);
        avg = (sum(num,1)./size(num,1));
        class_Ms(l,:) = avg; %get mean
        
        Q = length(num);
        Z = bsxfun(@minus, num, avg);
        covariance = 1/(Q-1) * (Z' * Z);
        class_Covs(l,:,:) = covariance + eye(D) * epsilon; %and get covariance
        
    end
    %add them to MMs and MCovs 
    MMs((L*(k-1)+1):(L*k), :) = class_Ms(:, :);
    MCovs((L*(k-1)+1):(L*k), :, :) = class_Covs(:, :, :);
    
    % and use them to run gaussian
    delta = -repmat(MMs(k,:)', 1, size(Xtest,1)) + Xtest';
    log_matrix = -delta' / squeeze(MCovs(k,:,:)) * delta - 0.5 * logdet(squeeze(MCovs(k,:,:)));
    likelihood(:,k) =  diag(0.5*log_matrix);
end
% and predict
[~, Ypreds] = max(likelihood, [], 2);
Ypreds = ceil(Ypreds./L)-1;
end
