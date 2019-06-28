%
%
function task1_4(EVecs)
% Input:
%  Evecs : the same format as in comp_pca.m
%
    digits = zeros(28, 28, 10);
    for i=1:10
        eigen_numbers = reshape(EVecs(:, i)*5, 28, 28)'; %reshape the first 10 eigenvectors (sorted by eigenvalue) to 28 by 28
        digits(:, :, i) = eigen_numbers;    %add to matrix to...
    end

    %note that eigenvalues have been multiplied by constant (5) to make them easier to view
    montage(digits, 'DisplayRange', [-0.5 0.5]); % show the eigenvectors 
    %print('-bestfit', 'task1_4_imgs.pdf', '-dpdf');
end
