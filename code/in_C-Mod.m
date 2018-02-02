% This script is the input file for Alcator C-Mod
% The parameters are gained from <Tokamaks>(4th edition) Page.598

% This input file is currently unavailable

clear all; close all
global tau bz nts ntp enable_source visual savedata denref Tref
path = 'D:\code_3d_linear_device_separate_den';
addpath(path);  addpath([path,'\analysis_utils']);

%  Switches
enable_source = 1;
restart = 0;
simulate = 1;
visual = 1;
savedata = 0;
make_movie = 0;
analyse = 0;


%  Basic parameters
Tref = 90;  % initial temperature at left boundary in eV
denref = 1.4e14;  %initial density at r = 0 in cm^-3
B0 = 53000;  %  Background Toroidal B in Gauss, ranges from 2.6 to 8.0T
mu = 2;  %  Ion mass over proton mass. Deuterium plasmas with hydrogen minority.
a = 22;  %  Minor radius 0.22m
R = 68;  %  Major radius 0.68m
rfpow = 6e-3;  %  total rf power input in kW
densrc = 0;  %  ionization rate per cm in z direction in cm^-1s^-1

%  Sizes
% The x of the simulation area has a range of
% [-close_flux_region_width, SOL_width]cm
close_flux_region_width = 5; 
SOL_width = 3;
% The y of the simulation area has a range of
% [-y_max, y_max]rho_s
y_max = 2;
nx = 50;  % x grid number
ny = 50;
nz = 30;
nz = 15;  %  grid count in z direction



intdenpdst = 3;  %  initial density max gradient position in cm
intdenwdth = 1;  %  initial density width in cm
intpepdst = 3;  %  initial temperature max gradient position in cm
intpewdth = 0.2;
densrcctr = 0;  %  density source center radius in cm
densrcwdth = 4.5;  %  density source width radius in cm  (which is 3 \sigma of the Gaussian distribution function)
pesrcctr = 0;
pesrcwdth = 4.5;

%  Steps
ntp = 25;
nts = 1000;
tau=0.01;  %  time step length in a/cs

%  Normalized small parameters
pert=1.e-10;
dif_in=0.006;  %  for r < rdif
dif_out = 0.15;  %  for r > rdif
difz_in = 0.02;
difz_out = 0.3;
bz=1;
calc_parameter;
if simulate
    scmod;
end
if make_movie
    movieMaker;
end
if analyse
    analysis;
end
draw_prifile
