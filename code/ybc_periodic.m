function a = ybc_periodic(a)

% This function implements y-direction boundary conditions to a given field a
% y direction is always periodic in our program

a(:, 1, :) = a(:, end-1, :);
a(:, end, :) = a(:, 2, :);

