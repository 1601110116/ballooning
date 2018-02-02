function h_pert = get_pert(h)
% This function substructs the y-direction mean of h and returns to h_pert
%  the boundaries are included to make the perturbed quantity the same size as the full one

h_pert = h - repmat(mean(h, 2), 1, size(h, 2), 1);

