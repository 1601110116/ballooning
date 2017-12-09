xs = 3;
xw = 1;
sp = 1;
r = 0:0.1:6;
y=sp*0.5*(1.-tanh((r-xs)/xw));
plot (r,y);

% r = -5:0.01:5;
% y = normpdf(r,0,1);
% plot(r,y)

% x = 0:0.001:2;
% y = sin(3*2*pi*x);
% plot(x,y)
% fmax = 1/0.001;
% f = linspace(0,fmax,length(x));
% yk = fft(y);
% plot(f,abs(yk))





% nx = 500;
% lx = 130;
% dx = lx/(nx-1);
% x = 0:dx:lx;
% x = x-lx/2;
% f0 = 2.5/lx;
% k0 = 2*pi*f0;
% w = -k0^2*cos(k0*x);
% plot(x,w);
% wk = fft(w);
% % figure; plot(abs(wk));
% fmax = 1/dx;
% fmin = 1/lx;
% k = 2*pi*linspace(0,fmax,nx);
% half = ceil(nx/2);
% for i = 2:half
%     k(nx-half+i) = -k(half+2-i);
% end
% % figure; plot(k,abs(wk));
% phik = zeros(1,nx);
% phik(2:end) = - wk(2:end) ./ k(2:end).^2;
% phi = ifft(phik);
% figure
% plot(x,real(phi));





% nx = 123;
% lx = 130;
% dx = lx/(nx-1);
% x = 0:dx:lx;
% ny = 2*nx;
% ly = lx;
% dy = ly/(ny-1);
% y = 0:dy:ly;
% x = x-lx/2;
% y = y-ly/2;
% x1 = x.*ones(ny,nx);
% y1 = y'.*ones(ny,nx);
% f0 = 2/lx;
% k0 = 2*pi*f0;
% w = -k0^2*cos(k0*(x1.^2+y1.^2).^0.5) .* ones(ny,nx,5);
% pcolor(x,y,w(:,:,3)); colormap jet; colorbar; shading interp
% wk = fft2(w);
% fxmax = 1/dx;
% kx = 2*pi*linspace(0,fxmax,nx);
% halfx = ceil(nx/2);
% for i = 2:halfx
%     kx(nx-halfx+i) = -kx(halfx+2-i);
% end
% fymax = 1/dy;
% ky = 2*pi*linspace(0,fymax,ny);
% halfy = ceil(ny/2);
% for i = 2:halfy
%     ky(ny-halfy+i) = -ky(halfy+2-i);
% end
% 
% kx1 = kx .* ones(ny,nx,5);
% ky1 = ky'.* ones(ny,nx,5);
% phik = zeros(ny,nx,5);
% phik(2:end,2:end,:) = - wk(2:end,2:end,:) ./ (kx1(2:end,2:end,:).^2+ky1(2:end,2:end,:).^2);
% figure;  pcolor(log(abs(phik(:,:,3)))); colormap jet; colorbar; shading interp
% 
% phi = ifft2(phik);
% figure; pcolor(x,y,real(phi(:,:,5))); colormap jet; colorbar; shading interp


% [x2,y2] = meshgrid(x,y');
% z2 = x2.*exp(-x2.^2-y.^2);
% pcolor(x2,y2,z2); shading interp
[x2,y2] = meshgrid(0:3,0:3,0:3);
