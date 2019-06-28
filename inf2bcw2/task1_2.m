%
%
function M = task1_2(X, Y)
% Input:
%  X : M-by-D data matrix (double)
%  Y : M-by-1 label vector (unit8)
% Output:
%  M : (K+1)-by-D mean vector matrix (double)
%      Note that M(K+1,:) is the mean vector of X.

    M = zeros(11, 784);
    all_mean = zeros(1, 784);

    for i=1:10
        mean_number = zeros(1, 784);
        label = X(Y==i-1, :);   %get the i-1th number (0..10)
        for j=1:size(label, 1)  %for each of the numbers
            all_mean = all_mean + label(j, :);  
            mean_number = mean_number + label(j, :);    %sum up all the i-1th numbers, for mean calc'
        end
        mean_number = mean_number/size(label, 1);   %calculate the mean number (only for one type of number, i-1)
        M(i, :) = mean_number;
    end
    M(11, :) = all_mean/size(X, 1); %one last time, to get an average vector for all numbers

    digits = zeros(28, 28, 11);     %put all the mean vectors into M
    for k=1:11
        N = reshape(M(k, :),28,28)';
        digits(:, :, k) = N;
    end
    montage(digits);    %show avg numbers
    %print('-bestfit', 'task1_2_imgs.pdf', '-dpdf');
end
