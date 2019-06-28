function [CM, acc] = comp_confmat(Ytrues, Ypreds, K)
% Input:
%   Ytrues : N-by-1 ground truth label vector
%   Ypreds : N-by-1 predicted label vector
% Output:
%   CM : K-by-K confusion matrix, where CM(i,j) is the number of samples whose target is the ith class that was classified as j
%   acc : accuracy (i.e. correct classification rate)

    CM = zeros(K,K);
    classes = unique([Ytrues;rmmissing(Ypreds)]); %get all the unique values in Ytrues, accounting for missing values
    L = length(classes);    % gets the correct K (L=K)
    for i = 1:L
        for j=1:L
            CM(i,j) = sum(Ytrues==classes(i) & Ypreds==classes(j)); %find everywhere where Ypreds and Ypreds match and add up the occurence
        end
    end
    acc = sum(diag(CM))/sum(sum(CM));   %diaglize the matrix, since it is the wrong shape, and caulcate hit rates (acc)
end
