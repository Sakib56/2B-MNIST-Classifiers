%
function [C, idx, SSE] = my_kMeansClustering(X, k, initialCentres, maxIter)
% Input
%   X : N-by-D matrix (double) of input sample data
%   k : scalar (integer) - the number of clusters
%   initialCentres : k-by-D matrix (double) of initial cluster centres
%   maxIter  : scalar (integer) - the maximum number of iterations
% Output
%   C   : k-by-D matrix (double) of cluster centres
%   idx : N-by-1 vector (integer) of cluster index table
%   SSE : (L+1)-by-1 vector (double) of sum-squared-errors

  %% If 'maxIter' argument is not given, we set by default to 500
  if nargin < 4
    maxIter = 500;
  end
  
  %% TO-DO
  
    C = initialCentres;
    N = size(X,1);
    idx_prev = zeros(N, 1); %locations of previous clusters
    dist = zeros(k, N);
    SSE = [];

    for i = 1:maxIter
        %calculate the distances from each cluster centre to all of the data points 
        for c = 1:k
            dist(c, :) = sum(bsxfun(@minus, X, C(c, :)).^2, 2)';
        end

        %minimise the distance matrix to extract the closest distance and new (index of) cluster locations
        [Ds, idx] = min(dist);
        SSE(i,1) = sum(Ds); %use the minimum distances to caluclate the sum square error
        
        % adding the new cluster centres for the next iteration (using the index previosuly calc'd)
        for c = 1:k
            if(sum(idx==c) ~= 0)
                C(c, :) = (sum(X(idx==c, :), 1) ./ size(X(idx==c, :), 1));
            end
        end
        
        % checks if kmeans has converged 
        if(idx_prev == idx)
            break; % (is the cluster from last iteration the same as this iteration, if so stop)
        end

        % store this iteration's assignments
        idx_prev = idx;
    end

    %calulating the sse one last time, after kmeans has converged
    for c = 1:k
        dist(c, :) = sum(bsxfun(@minus, X, C(c, :)).^2, 2)';
    end
    [Ds, idx] = min(dist, [], 1);
    SSE(i,1) = sum(Ds);

end
