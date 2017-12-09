function h=sbdel(g)
global dzt1p5

h = dzt1p5*(g(2:end-1,2:end-1,3:end)-g(2:end-1,2:end-1,1:end-2));
