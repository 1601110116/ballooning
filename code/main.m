
%global p pe den lnp lnpe lnden lnp_aux lnpe_aux lnden_aux vi w vi_aux w_aux ...
%   	jz ve Te phi vEx vEy last_diagnose ddzzdt ddxxdt ddyydt convxdt convydt ...
%	curvxdt curvydt theta difxxdt difyydt difzzdt difxydt src_p src_pe src_den ...
%   	lap nx ny nz nx_LCSF curv_phi ddz_ve
global last_diagnose

read_parameters;

build_fft_coefficient_matrix(enable_shear, dx, nx, ny, nz, y_max);

generate_constants(enable_curvature, enable_shear, shear, inv_aspect_ratio, ...
	q, minor_radius, dx, dy, dz, nx, ny, nz, dt, dif_mode, ...
   	dif_perp_magnitude, dif_perp_width, dif_z_magnitude, dif_z_width, ...
   	source_mode, src_p_magnitude, src_p_width, src_pe_magnitude, ...
   	src_pe_width, src_den_magnitude, src_den_width);

initialize(simulate_mode, init_mode, init_magnitude, init_width, ...
	init_perturbation);

diagnose_normalized(last_diagnose, nt_per_diagnose);
diagnose_start = last_diagnose + 1;
for idiagnose = diagnose_start : ndiagnose
	disp(['step ', num2str(idiagnose), ' of ', num2str(ndiagnose)])
	for it = 1:nt_per_diagnose
		f = 0.5;  fi = 0.5;  % constants for the time-advancing method
		sterms();
		slnp(f, fi);
		slnpe(f, fi);
%		slnden(f, fi);
		svi(f, fi);
		sw(f, fi);
		sdata();

		f = 1.0;  fi = 0.0;
		sterms();
		slnp(f, fi);
		slnpe(f, fi);
%		slnden(f, fi);
		svi(f, fi);
		sw(f, fi);
		sdata();
	end
	diagnose_normalized(idiagnose, nt_per_diagnose);
	last_diagnose = idiagnose;
	save('parameters.mat', 'last_diagnose', '-append');
end

