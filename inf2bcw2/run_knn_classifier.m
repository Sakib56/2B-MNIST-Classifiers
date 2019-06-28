function [Ypreds] = run_knn_classifier(Xtrain, Ytrain, Xtest, Ks)
% Input:
%   Xtrain : M-by-D training data matrix (double)
%   Ytrain : M-by-1 label vector (uint8) for Xtrain
%   Xtest  : N-by-D test data matrix (double)
%   Ks     : 1-by-L vector (integer) of the numbers of nearest neighbours in Xtrain
% Output:
%   Ypreds : N-by-L matrix (uint8) of predicted labels for Xtest

    L = size(Ks, 2);
    M = size(Xtrain, 1);
    N = size(Xtest, 1);

    XX = sum(Xtest .^ 2, 2);
    YY = sum(Xtrain .^ 2, 2);
    DI = repmat(XX, 1, M) - 2 * Xtest * Xtrain' + repmat(YY, 1, N)'; %matrix distance calculation on inf2b help sheet

    [~, idx] = sort(DI, 2, 'ascend'); %get indexes of the sorted distance matrix for counting...

    Ypreds = zeros(N, L);
    for i = 1:L
        k = Ks(i);
        Ypreds(:, i) = Ytrain(mode(idx(:, 1:k)',1)); %count (mode) the k closest neighbours and make a prediction
    end
end