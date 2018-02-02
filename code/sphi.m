function sphi()
% This function solves the Poisson equation to get phi.
%  the method is explained in DocPoisson.pdf
global w phi p den nx ny nz dx lap
%  all these persistent parameters excludes boundaries
persistent wky nphi_plus_p tmp_col

for iz = 2:nz+1
	wky = w(2:end-1, 2:end-1, iz);
	wky(end, :) = wky(end, :) - (1/dx^2).*p(end, 2:end-1, iz);
	% this may be further optimized to (nphi = n*3*Te)
	%wky(end, :) = wky(end, :) - 1/dx^2.*(p(end, 2:end-1, iz)+3*pe(end, 2:end-1, iz))
	wky = fft(wky, [], 2);
	tmp_col = reshape(wky, nx*ny, 1);
	% the operator lap excludes boundaries
	tmp_col = lap{iz-1} \ tmp_col;
	nphi_plus_p = reshape(tmp_col, nx, ny);
	nphi_plus_p = real(ifft(nphi_plus_p, [], 2));
	phi(2:end-1, 2:end-1, iz) = nphi_plus_p - p(2:end-1, 2:end-1, iz);
end
phi = phi ./ den;
phi = xbc_free(phi);
phi = ybc_periodic(phi);
phi = zbc_periodic_free(phi);
phi(end, :, :) = 0;
