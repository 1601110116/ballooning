function build_fft_coefficient_matrix(enable_shear, dx, nx, ny, nz, y_max)

% The electrostatic potential is acquired by solving a 2D Poisson equation.
%  please read DocPoisson.pdf if you want to understand this code

global lap

lap1 = -2*speye(nx) + sparse(diag(ones(1,nx-1), 1) + diag(ones(1,nx-1), -1));
lap1(1,1) = -1;
lap1 = kron(speye(ny), lap1/dx^2);
ky = zeros(ny, 1);
tmp1 = pi/y_max;
nky = ny/2 + 1; % the count of ky that >=0
%for j = nky
%	ky(j) = tmp1 * (j-1);
%end
%for j = nky+1:ny
%	ky(j) = tmp1 * (j-1-ny);
%end
ky(1:nky) = tmp1*linspace(0, nky-1,nky);
ky(nky+1:ny) = tmp1*((nky:1:ny-1) - ny);
lap = cell(nz, 1);
if ~enable_shear
	% lap2=0, lap3 is independent of z if magnetic shear is disabled
	lap3 = kron(-diag(ky.*ky), speye(nx));
	for k = 1:nz
		lap{k} = lap1 + lap3;
	end
	clear lap1 lap3 ky;
elseif enable_shear

end
