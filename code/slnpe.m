function slnpe(f, fi)
% This function advances lnpe, calculates pe and applies their boundary conditions
global lnpe lnpe_aux pe ve src_pe curv_phi ddz_ve
persistent result

result = f*lnpe_aux(2:end-1, 2:end-1, 2:end-1) + fi * lnpe(2:end-1, 2:end-1, 2:end-1) ...
	- 5/3*(curv_phi+ddz_ve) - ve(2:end-1, 2:end-1, 2:end-1).*ddz(lnpe) ...
	- convect(lnpe) + diffuse(lnpe);
[err_ix, err_iy, err_iz] = ind2sub(size(result), find(isnan(result)));
if ~isempty(err_ix)
	disp('slnpe: NaN found, simulation paused for debugging');
	pause;
end
if f < 0.6
	lnpe_aux = lnpe;
end
lnpe(2:end-1, 2:end-1, 2:end-1) = result;
pe(2:end-1, 2:end-1, 2:end-1) = exp(lnpe(2:end-1, 2:end-1, 2:end-1)) + src_pe;
pe = xbc_free(pe);
pe = ybc_periodic(pe);
pe = zbc_periodic_free(pe);
lnpe = log(pe);
