function sheath_bc()
% This function implements sheath boundary conditions in the SOL
%  this functions is called by the function sdata.m
global vi jz Te den phi nx_LCFS
%  Cs: ion sound speed at limiter
%  jz0: parallel current at limiter
persistent Cs jz0
Cs = -sqrt(Te(nx_LCFS+1:end, :, 1));
vi(nx_LCFS+1:end, :, 1) = 2*Cs - vi(nx_LCFS+1:end, :, 2);
jz0 = den(nx_LCFS+1:end, :, 1) .* Cs .* (1-exp(3-(3 ...
    + phi(nx_LCFS+1:end, :, 1))./Te(nx_LCFS+1:end, :, 1)));
jz(nx_LCFS+1:end, :, 1) = 2*jz0 - jz(nx_LCFS+1:end, :, 2);

Cs = sqrt(Te(nx_LCFS+1:end, :, end));
vi(nx_LCFS+1:end, :, end) = 2*Cs - vi(nx_LCFS+1:end, :, end-1);
jz0 = den(nx_LCFS+1:end, :, end) .* Cs .* (1-exp(3-(3 ...
    + phi(nx_LCFS+1:end, :, end))./Te(nx_LCFS+1:end, :, end)));
jz(nx_LCFS+1:end, :, end) = 2*jz0 - jz(nx_LCFS+1:end, :, end-1);

end

% this may be further optimized to
%
%Cs = -sqrt(Te(nx_LCFS+1:end, :, 1));
%vi(nx_LCFS+1:end, :, 1) = 2*Cs - vi(nx_LCFS+1:end, :, 2);
%jz(nx_LCFS+1:end, :, 1) = 0;
%phi(nx_LCFS+1:end, :, 1) = 3*Te(nx_LCFS+1:end, :, 1);
%
%Cs = sqrt(Te(nx_LCFS+1:end, :, end));
%vi(nx_LCFS+1:end, :, end) = 2*Cs - vi(nx_LCFS+1:end, :, end-1);
%jz(nx_LCFS+1:end, :, end) = 0;
%phi(nx_LCFS+1:end, :, end) = 3*Te(nx_LCFS+1:end, :, end);
