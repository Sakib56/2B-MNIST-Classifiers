%
%
function task2_1(Xtrain, Ytrain, Xtest, Ytest, Ks)
% Input:
%  Xtrain : M-by-D training data matrix (double)
%  Ytrain : M-by-1 label vector (unit8) for Xtrain
%  Xtest  : N-by-D test data matrix (double)
%  Ytest  : N-by-1 label vector (unit8) for Xtest
%  Ks     : 1-by-L vector (integer) of the numbers of nearest neighbours in Xtrain

    N = size(Xtest, 1);
    K = size(Ks, 2);
    for i=1:K
        tic
        Ypreds = run_knn_classifier(Xtrain, Ytrain, Xtest, Ks(i)); %knn with values in Ks
        toc % get runtime of knn

        [CM, acc] = comp_confmat(Ytest, Ypreds, Ks(i));
        Nerrs = N - N*acc;

        %save(sprintf('task2_1_cm%g.mat',Ks(i)),'CM') %save the confusion matrix
        % relevant information
        fprintf('k: %g\n',Ks(:,i));
        fprintf('N: %g\n',N);
        fprintf('Nerrs: %g\n',Nerrs); 
        fprintf('acc: %g\n\n',acc); 
    end
end
