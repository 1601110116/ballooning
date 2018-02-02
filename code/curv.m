function h = curv(g)
global curvxdt curvydt
h = curvxdt .* (g(3:end, 2:end-1, 2:end-1) - g(1:end-2, 2:end-1, 2:end-1)) ...
	+ curvydt .* (g(2:end-1, 3:end, 2:end-1) - g(2:end-1, 1:end-2, 2:end-1));

