function slnp(f, fi)
% This function advances lnp, calculates p and applies their boundary conditions
global lnp lnp_aux p vi src_p curv_phi
persistent result

result = f*lnp_aux(2:end-1, 2:end-1, 2:end-1) + fi*lnp(2:end-1, 2:end-1, 2:end-1) ...
	- 5/3*(curv_phi+ddz(vi)) - vi(2:end-1, 2:end-1, 2:end-1).*ddz(lnp) ...
	- convect(lnp) + diffuse(lnp);
[err_ix, err_iy, err_iz] = ind2sub(size(result), find(isnan(result)));
if ~isempty(err_ix)
	disp('slnp: NaN found, simulation paused for debugging');
	pause;
end
if f < 0.6
	lnp_aux = lnp;
end
lnp(2:end-1, 2:end-1, 2:end-1) = result;
p(2:end-1, 2:end-1, 2:end-1) = exp(lnp(2:end-1, 2:end-1, 2:end-1)) + src_p;
p = xbc_free(p);
p = ybc_periodic(p);
p = zbc_periodic_free(p);
lnp = log(p);
