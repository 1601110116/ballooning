function a = xbc_floating(a)

% This function implements x-direction boundary conditions to a given field a
% Floating boundary is used for both closed field line region and SOL

a(1, :, :) = a(2, :, :);
a(end, :, :) = a(end-1, :, :);

