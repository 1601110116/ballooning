function sterms()
% This function calculates terms that will be further used for time advancing.
%  They are calculated here because they are shared by more than 1 equations.
%  We don't have boundary grids for these terms because they are never needed
global curv_phi ddz_ve phi ve
curv_phi = curv(phi);
ddz_ve = ddz(ve);
end
