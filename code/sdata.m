function sdata()
% This function solves other quantities to be saved other than the
%  time-advancing quantities, as well as implements sheath boundary
%  conditions to vi in SOL

global pe vi jz ve Te phi vEx vEy den inv_nustar ddxx ddyy

Te = pe ./ den;
sphi();
jz(2:end-1, 2:end-1, 2:end-1) = inv_nustar * (ddz(pe) ...
	- den(2:end-1, 2:end-1, 2:end-1) .* ddz(phi));
jz = zbc_periodic_free(jz);
sheath_bc();
jz = xbc_free(jz);
jz = ybc_periodic(jz);

ve = vi - jz./den;

vEx(:, 2:end-1, :) = ddyy .* (phi(:, 1:end-2, :) - phi(:, 3:end, :));
vEy(2:end-1, :, :) = ddxx .* (phi(3:end, :, :) - phi(1:end-2, :, :));

vEx = ybc_periodic(vEx);
vEy = xbc_free(vEy);

end
