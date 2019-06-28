%
%
function task1_1(X, Y)
% Input:
%  X : M-by-D data matrix (double)
%  Y : M-by-1 label vector (unit8)

    for i=1:10
        digits = zeros(28, 28, 11);
        for j=1:10
            label = X(Y==i-1,:);    %get all the numbers that are j-1 (0..10)
            current_number = reshape(label(j, :), 28, 28)';     %reshape vector into 28 by 28
            digits(:, :, j) = current_number;   %add to matrix
        end
        figure
        montage(digits);    %show matrix as a figure
        %print('-bestfit', sprintf('task1_1_imgs_class%d.pdf', i), '-dpdf');
    end
end
