function sw(f, fi)
% This function advances w and applies its boundary conditions
global w w_aux p pe jz
persistent result

result = f*w_aux(2:end-1, 2:end-1, 2:end-1) + fi*w(2:end-1, 2:end-1, 2:end-1) ...
	+ curv(p+pe) + ddz(jz) - convect(w) + diffuse(w);
[err_ix, err_iy, err_iz] = ind2sub(size(result), find(isnan(result)));
if ~isempty(err_ix)
	disp('sw: NaN found, simulation paused for debugging');
	pause;
end
if f < 0.6
	w_aux = w;
end
w(2:end-1, 2:end-1, 2:end-1) = result;
w = xbc_free(w);
w = ybc_periodic(w);
w = zbc_periodic_free(w);
