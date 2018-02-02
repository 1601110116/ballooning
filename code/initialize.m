function initialize(simulate_mode, init_mode, init_magnitude, init_width, ...
	   init_perturbation)	
% This function gets the initial values of all simulated quantities
	global p pe den lnp lnpe lnden lnp_aux lnpe_aux lnden_aux vi w vi_aux w_aux jz ve Te phi vEx ...
		vEy last_diagnose nx ny nz
	if simulate_mode == 1
		if init_mode == 1
			p = init_magnitude + init_perturbation*rand(nx+2, ny+2, nz+2);
			pe = p;  den = p;
		elseif init_mode == 2

		elseif init_mode == 3

		else
			error('Invalid init_mode')
		end
		p = xbc_free(p);  p = ybc_periodic(p);  p = zbc_periodic_free(p);
		pe = xbc_free(pe);  pe = ybc_periodic(pe);  pe = zbc_periodic_free(pe);
		den = xbc_free(den);  den = ybc_periodic(den);  den = zbc_periodic_free(den);

		vi = zeros(nx+2, ny+2, nz+2);  w = vi;
		vi = xbc_free(vi);  vi = ybc_periodic(vi);  vi = zbc_periodic_free(vi);
		w = xbc_free(w);  w = ybc_periodic(w);  w = zbc_periodic_free(w);

		jz = zeros(nx+2, ny+2, nz+2);  ve = jz;  Te = jz;  phi = jz;  vEx = jz;  vEy = jz;
		sdata();
	elseif simulate_mode == 2
		% get the name of the last data file in current directory and load
		last_file = ['dat', sprintf('%4.4d', last_diagnose), '.mat'];
		if ~exist(last_file, 'file')
			error('No dat****.mat found. Mode 2 unavailable');
		end
		load(last_file);
	elseif simulate_mode == 3
		% get the name of the last data file in the previous directory
		if ~exist('../parameters.mat', 'file')
			error('No parameters.mat in ../  . Mode3 unavailable');
		end
		load('../parameters.mat', 'last_diagnose');
		last_file = ['dat', sprintf('%4.4d', last_diagnose), '.mat'];
		last_diagnose = 0;
		% copy the last data file in the previous directory to current
		% directory as rest.mat and then load it
		if ~exist(['../',last_file], 'file')
			error('No dat****.mat file in ../   . Mode 3 unavailable');
		end
		copyfile(['../',last_file], 'rest.mat');
		load rest.mat
	else
		error('Invalid simulate_mode');
	end
	lnp = log(p);  lnpe = log(pe);  lnden = log(den);
	lnp_aux = lnp;  lnpe_aux = lnpe;  lnden_aux = lnden;
	vi_aux = vi;  w_aux = w;

end
