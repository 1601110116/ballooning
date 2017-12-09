function [ vtht, vr ] = vec2pol( vx, vy )
%VEC2POL This function converts a vector field in cylindrical grid whose
%   components are in cartesian coordinate to a vector field whose components
%   are in polar coordinate. All the output components has base vectors
%   that are orthonormal.
%   vx: The x component of the vector field, which is a scalar field
%   vtht: The \theta component of the vector field, whose base vector is
%       the normalized \hat\theta

global thtp 

vr = vx .* cos(thtp) + vy .* sin(thtp);
vtht = -vx .* sin(thtp) + vy .* cos(thtp);


end

