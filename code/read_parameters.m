% This script reads input parameters for simulation, and saves parameters for further analysis.

global last_diagnose nx_LCFS x y z theta dx dy dz
if simulate_mode == 1
	if exist('../in_*.m', 'file')
		error('You are in a further/ directory. Mode 1 unavailable.');
	end
end
if simulate_mode == 1 || simulate_mode == 3
	last_diagnose = 0;
	if ~exist('further', 'dir')
		mkdir('further');
	end
	copyfile('in_*.m', 'further/');
	if experiment_input
		% translate experimental parameters to normalized ones

	else


	end
	dx = (closed_flux_region_width + SOL_width) / (nx-1);
	dy = 2 * y_max / (ny-1);
	dz = 1 / nz;
	% coordinates of the grids, including boundaries
	x = linspace(-closed_flux_region_width - dx, SOL_width + dx, nx+2);
	y = linspace(-y_max - dy, y_max + dy, ny+2);
	z = (-dz:dz:nz*dz) - 0.25 * limiter_place; % z=0 at outer mid-plane
	theta = 2*pi*z;
	%     closed_width LCFS SOL_width   
	%      _____________|___________
	%  .   .   .   .   .|  .   .   .   .    e.g. nx=7
	%  |               |               |
    %boundary      nx_LCFS=5	    boundary
	nx_LCFS = floor(closed_flux_region_width / dx) + 2;

	
	save parameters.mat
elseif simulate_mode == 2
	if ~exist('parameters.mat', 'file')
		error('No parameters.mat file found. Mode 2 unavailable');
	end
	load parameters.mat
end



