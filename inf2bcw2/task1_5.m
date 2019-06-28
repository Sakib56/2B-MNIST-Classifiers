%
%
function task1_5(X, Ks)
% Input:
%  X  : M-by-D data matrix (double)
%  Ks : 1-by-L vector (integer) of the numbers of nearest neighbours

    hold on
    for k=1:size(Ks,2)
        fprintf('\nk = %d\n',Ks(k))
        I = X(1:Ks(k),:); %initial
        tic
        [C, idx, SSE] = my_kMeansClustering(X, Ks(k), I, 100); %run kmenas with numbers in Ks
        toc %get runtime of k means
        % code to save c, idx and sse
%         save(sprintf('task1_5_c_%d.mat',Ks(k)),'C');
%         save(sprintf('task1_5_idx_%d.mat',Ks(k)),'idx')
%         save(sprintf('task1_5_sse_%d.mat',Ks(k)),'SSE')
        plot(SSE) %plot the sse
        xlabel('Iteration number');
        ylabel('SSE');
    end
    hold off
end
