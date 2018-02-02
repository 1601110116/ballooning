%  This scrip is the input file that only takes normalized quantities
%  All input files should be named by in_*.m !
% The time-advanced quantities are (always labels the lastest of them)
%  p: ion temperature
%  pe: electron temperature
%  den: density (quasi-neutrality)
%  vi: ion parallel velocity
%  w: vorticity
%  in practice, we advance the logorithm of p, pe and den, so that they
%  are more accurately solved when they are small
% these quantities are appended by '_aux' if they are auxiliary 
% quantities for our time-advancing scheme, e.g.
%  w_aux: auxiliary ion vorticity
% other quantities are (always labels the latest of them)
%  jz: parallel current
%  ve: electron paralle velocity
%  Te: electron Temperature
%  phi: electrostatic potential
%  vEx: EXB velocity in r direction
%  vEy: EXB velocity in \theta direction
%  all these 11 quantities are saved in dat****.mat normalized

global limiter_place dt nt_per_diagnose nx ny nz inv_nustar savedata visual ...
    make_movie analyse

%  the path of the case
case_path = '/home/ylang/Documents/Research/L-H transition/ballooning';
code_path = [case_path,'/code'];
addpath(code_path);


experiment_input = 0; % the type of this inputfile is normalized
%  Mode selection
% 1: start from the very beginning of the simulation
% 2: continue from the last .mat file. Nothing in this file should 
%    be changed except ndiagnose
% 3: continue from the last .mat in ../  . Used to simulate in 
%    different parameters
simulate_mode = 1;


%  Missions
visual = 1;
savedata = 1;
make_movie = 0;
analyse = 0;


%  Time step
dt = 0.005; % time step width
nt_per_diagnose = 80;
% total diagnose times you want in current directory, which may not be 
% finished since the program might be interrupted.
ndiagnose = 40; 


%  Tokamak settings
% 0 for outside, 1 for bottom, 2 for inside
limiter_place = 2;
inv_aspect_ratio = 0.3;
q = 3;  % Safty factor 
minor_radius = 200; % in rho_s

%  Grid  (Grids to implement boundary conditions are not included)
% define x=r-r0, y=r0(\theta-\theta0);
% the x of the simulation area has a range of 
% [-close_flux_region_width, SOL width]rho_s
closed_flux_region_width = 39.84;
SOL_width = 35.16;
% the y of the simulation area has a range of
% [-y_max, y_max]rho_s
y_max = 50;
% grid numbers in the 3 directions. 
nx = 192;
ny = 256;  % has to be an even number
nz = 18;


% Geometry Effects
enable_curvature = 1;
% magnetic shear (r0/q0)dq/dr
enable_shear = 0;
shear = 1;

%  Coefficients
% inverse of (me/mi)\nu_e, nu_e is e-i collision frequency
inv_nustar = 1;
% diffusion coefficients centered at left boundary
% 1 for uniform, 2 for Gaussian, 3 for tanh
dif_mode = 1;
% uniform

% Gaussian

% tanh

% perpendicular diffusion coefficient in rho_s^2/(a/cs0)
dif_perp_magnitude = 0.5;
dif_perp_width = 0;
% parallel diffusion coefficient in Lz^2/(a/cs0)
dif_z_magnitude = 0.1;
dif_z_width = 0;

%  Initial Conditions
% initial p, pe and den centered at left boundary
% 1 for uniform, 2 for Gaussian, 3 for tanh
init_mode = 1;
% uniform

% Gaussian

% tanh

% this program enforces the initial values of p, pe and tanh to be
%  the same. Since p and pe are normalized by the same quantity, this
%  program does't support different p and pe initial values
init_magnitude = 1;
init_width = 0;
init_perturbation = 1e-5;

%  Boundary
% we always use free boundary conditions in x direction except phi
% we always use periodic boundary condition in y direction
% in z direction, we use periodic boundary condition for 
% x < 0 and sheath boundary condition for x > 0

%  Source
% source centered at left boundary
% 1 for zero, 2 for Gaussian, 3 for tanh
source_mode = 1;
% zero

% Gaussian

% tanh

src_p_magnitude = 0;
src_p_width = 0;
src_pe_magnitude = 0;
src_pe_width = 0;
src_den_magnitude = 0;
src_den_width = 0;


main;

