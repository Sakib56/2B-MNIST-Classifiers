%
%
function task1_8(X, Ks, initialOption)
%  NB: there is no specification to this function.
% initialOption = {0,1,2}

    N = size(X, 1);
    K = size(Ks, 2);

    for k=1:K
        fprintf('\nk = %d\n',Ks(k))

        % initialOption <- 0
        % k observations sampled uniformly at random, with replacement, from the data in X
        if initialOption == 0
            initial = datasample(X,Ks(k));
            type = ' random initialisation';
        end

        % initialOption <- 1
        % computes pca, and uses the first k most significant eigenvectors as the init' cluster centres
        if initialOption == 1
            [EVecs, ~] = comp_pca(X);
            initial = EVecs(:, 1:Ks(k))';
            type = ' k most significant eigenvector clusters';
        end

        % initialOption <- 2
        % splits X into k partitions, gets k means from those partitions
        % and uses those and cluster centres
        if initialOption == 2
           initial = [];
           for i=1:Ks(k)
               s = floor(N/Ks(k));
               numbers = X(s*(i-1)+1:s*i,:);
               mean_i = ( sum(numbers, 1) ./ size(numbers,1) )';
               initial(i,:) = (sum(mean_i,1)./size(mean_i,1));
           end
           size(initial)
           type = ' partitioned mean cluster';
        end

        tic
        [~, ~, SSE] = my_kMeansClustering(X, Ks(k), initial, 100);
        toc

        figure
        plot(SSE)
        title(strcat('KMeans w/ ',type));
        xlabel('Iteration number');
        ylabel('SSE');
    end
end
