function generate_constants(enable_curvature, enable_shear, shear, ...
		inv_aspect_ratio, q, minor_radius, dx, dy, dz, nx, ny, nz, dt, ...
	   	dif_mode, dif_perp_magnitude, dif_perp_width, dif_z_magnitude, ...
	   	dif_z_width, source_mode, src_p_magnitude, src_p_width, ...
		src_pe_magnitude, src_pe_width, src_den_magnitude, src_den_width)
% This function generates all contants used by the simulation
%  in this program ddz means the operator d/dz
%  the coefficients are named by operator + direction + (dt)
%  the generated constants can be a scalar, or a scalar field excluding boundaries
global ddzzdt ddxx ddyy convxdt convydt curvxdt curvydt theta difxxdt ...
   	difyydt difzzdt difxydt src_p src_pe src_den 

if ~enable_shear
	% parallel derivative
	%  z: r0/Lz * 1/(2*dz) * dt, Lz = 2pi * R0 * q
	ddzzdt = inv_aspect_ratio / (2*pi*q) / (2*dz) * dt;

	% perpendicular derivative
	ddxx = 1 / (2*dx);
	ddyy = 1 / (2*dy);

	% perpendicular convection
	%  x: r0/rho_s * 1/(2*dx) * dt
	%  y: r0/rho_s * 1/(2*dy) * dt
	convxdt = minor_radius / (2*dx) * dt;
	convydt = minor_radius / (2*dy) * dt;
	
	% curvature
	%  x: -2r0/R0 * sin\theta * 1/(2*dx) * dt
	%  y: -2r0/R0 * cos\theta * 1/(2*dy) * dt
	curvxdt = enable_curvature * (-2*inv_aspect_ratio) / (2*dx) * ...
		sin(theta(2:end-1)) * dt;
    curvxdt = repmat(reshape(curvxdt,1,1,[]), nx, ny, 1);
	curvydt = enable_curvature * (-2*inv_aspect_ratio) / (2*dy) * ...
		cos(theta(2:end-1)) * dt;
    curvydt = repmat(reshape(curvydt,1,1,[]), nx, ny, 1);


	% diffusion
	if dif_mode == 1
		difxxdt = dif_perp_magnitude / (dx^2) * dt;
		difyydt = dif_perp_magnitude / (dy^2) * dt;
		difzzdt = dif_z_magnitude / (dz^2) * dt;
	elseif dif_mode == 2


	elseif dif_mode == 3


	end

	% source
	if source_mode == 1
		src_p = 0;
		src_pe = 0;
		src_den = 0;
	elseif source_mode == 2
% Gaussian source:  f(x) = magnitude/(sqrt(2*pi)*width)*exp(-x^2/(2*width^2))
%                     source added here
%                  ______________________
% girds:    .      .      .      .      .      .       nx=4
%     x: boundary  0     dx     2dx    3dx  boundary
		src_p = dt*src_p_magnitude * normpdf(linspace(0, (nx-1)*dx, nx), 0, src_p_width);
		src_pe = dt*src_pe_magnitude * normpdf(linspace(0, (nx-1)*dx, nx), 0, src_pe_width);
		src_den = dt*src_den_magnitude * normpdf(linspace(0, (nx-1)*dx, nx), 0, src_den_width);
		src_p = repmat(reshape(src_p,[],1,1), 1, ny, nz);
		src_pe = repmat(reshape(src_pe,[],1,1), 1, ny, nz);
		src_den = repmat(reshape(src_den,[],1,1), 1, ny, nz);
		
	elseif source_mode == 3


	end

else



end

end
