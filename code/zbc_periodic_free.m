function a = zbc_periodic_floating(a)

% This function implements z-direction boundary conditions to
%  a given field a
%
% Periodic boundary conditions for closed field line region
% Floating boundary conditions for SOL

global nx_LCFS

a(1:nx_LCFS, :, 1) = a(1:nx_LCFS, :, end-1);
a(1:nx_LCFS, :, end) = a(1:nx_LCFS, :,2);
a(nx_LCFS+1:end, :, 1) = a(nx_LCFS+1:end, :, 2);
a(nx_LCFS+1:end, :, end) = a(nx_LCFS+1:end, :, end-1);
