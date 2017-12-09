function fp = grid2pol( f )

%TO_POL This function casts a 3D field matrix from cartesian grid to
% polar grid. It must be called by analysis.m
%   f: original 3D field in cartesian grid

%   f_pol: 3D field in cylindrical grid
%   meshes are acquired by global parameters

global xc yc zc xp yp zp

fp = interp3(xc, yc, zc, f, xp, yp, zp);

end

