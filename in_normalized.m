% This scrip is the input file that only takes normalized quantities

% Switches
enable_source = 1;
enable_curvature = 1;
restart = 1;
simulate = 1;
visual = 1;
savedata = 0;
make_movie = 0;
analyse = 0;


%  Tokamak settings
% 0 for outside, 1 for bottom, 2 for inside
limiter_place = 2;
% The x of the simulation area has a range of 
% [-close_flux_region_width, SOL width]rho_s
close_flux_region_width = 39.84;
SOL_width = 35.2;
% The y of the simulation area has a range of
% [-y_max, y_max]rho_s
y_max = 50;
inv_aspect_ratio = 0.3;

