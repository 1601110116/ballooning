function slnden(f, fi)
% This function advances lnden, calculates den and applies their boundary conditions
global Te lnden lnden_aux den lnpe ve src_den curv_phi ddz_ve
persistent result

result = f*lnden_aux(2:end-1, 2:end-1, 2:end-1) + fi*lnden(2:end-1, 2:end-1, 2:end-1) ...
	+ Te(2:end-1, 2:end-1, 2:end-1).*curv(lnpe) - curv_phi ...
	- ve(2:end-1, 2:end-1, 2:end-1) .* ddz(lnden) - ddz_ve ...
	- convect(lnden) + diffuse(lnden);
[err_ix, err_iy, err_iz] = ind2sub(size(result), find(isnan(result)));
if ~isempty(err_ix)
	disp('slnden: NaN found, simulation paused for debugging');
	pause;
end
if f < 0.6
	lnden_aux = lnden;
end
lnden(2:end-1,2:end-1,2:end-1) = result;
den(2:end-1,2:end-1,2:end-1) = exp(lnden(2:end-1,2:end-1,2:end-1)) + src_den;
den = xbc_free(den);
den = ybc_periodic(den);
den = zbc_periodic_free(den);
lnden = log(den);

