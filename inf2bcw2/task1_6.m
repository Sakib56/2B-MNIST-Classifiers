%
%
function task1_6(MAT_ClusterCentres)
% Input:
%  MAT_ClusterCentres : file name of the MAT file that contains cluster centres C.
%       
% 
    load(MAT_ClusterCentres,'C'); %load Cluster Centres as C
    K = size(C, 1);
    
    digits =  zeros(28, 28, K);
    for i=1:K
        N = reshape(C(i, :),28,28)'; %reshape C into 28by28 to show...
        digits(:, :, i) = N;
    end
    
    montage(digits) %show cluster centres as images
    %print('-bestfit', sprintf('task1_6_imgs_%d.pdf',K), '-dpdf'); % save the pdf (plot)
end
