function svi(f, fi)
% This function advances vi and applies its boundary conditions
%  note that the z-direction sheath boundary condition in SOL is not applied here
global vi vi_aux den p pe
persistent result

result = f*vi_aux(2:end-1, 2:end-1, 2:end-1) + fi*vi(2:end-1, 2:end-1, 2:end-1) ...
	- ddz(p+pe)./den(2:end-1, 2:end-1, 2:end-1) ...
    - convect(vi) + diffuse(vi) ...
	- vi(2:end-1, 2:end-1, 2:end-1) .* ddz(vi);
	% this may be further optimized to
%result = f*vi_aux(2:end-1, 2:end-1, 2:end-1) + fi*vi(2:end-1, 2:end-1, 2:end-1) ...
%	-ddz(p+pe)./den(2:end-1, 2:end-1, 2:end-1) ...
%	- p(2:end-1, 2:end-1, 2:end-1)./den(2:end-1, 2:end-1, 2:end-1).*curv(vi) ...
%	- convect(vi) + diffuse(vi);
[err_ix, err_iy, err_iz] = ind2sub(size(result), find(isnan(result)));
if ~isempty(err_ix)
	disp('svi: NaN found, simulation paused for debugging');
	pause;
end
if f < 0.6
	vi_aux = vi;
end
vi(2:end-1, 2:end-1, 2:end-1) = result;
vi = xbc_free(vi);
vi = ybc_periodic(vi);
vi = zbc_periodic_free(vi);
