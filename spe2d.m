function spe2d( )
global kx1 ky1 nx0 ny0 nz0 phi jz ve vex vey dx1p5 dy1p5 ...
    wi deni pei denref Tref mu t0 tau vii bz calc
persistent wk phik realT realden nustar

if isempty(phik)
    phik = zeros(nx0,ny0,nz0);
end
wk = fft2(wi(2:end-1,2:end-1,2:end-1));
phik(2:end,2:end,:) = - wk(2:end,2:end,:) ./ (kx1(2:end,2:end,:).^2+ky1(2:end,2:end,:).^2);
phi(2:end-1,2:end-1,2:end-1) =  calc .* (real(ifft2(phik)));
phi = sbcznn(phi);
vex(2:end-1,2:end-1,2:end-1) = calc .* (-bz*dy1p5*(phi(3:end,2:end-1,2:end-1)-phi(1:end-2,2:end-1,2:end-1)));
vey(2:end-1,2:end-1,2:end-1) = calc .* (bz*dx1p5*(phi(2:end-1,3:end,2:end-1)-phi(2:end-1,1:end-2,2:end-1)));
vex = sbcznn(vex);
vey = sbcznn(vey);
% realT = Tref*pei(2:end-1,2:end-1,2:end-1)./deni(2:end-1,2:end-1,2:end-1);
% realden = denref*deni(2:end-1,2:end-1,2:end-1);
realT = Tref*ones(nx0,ny0,nz0);
realden = denref*ones(nx0,ny0,nz0);
nustar = 2.906e-6*(22.36+1.5.*log(realT)-0.5.*log(realden)).*realden.*realT.^-1.5.*t0./(mu*1836);
% nustar = 2.906e-4*(22.36+1.5.*log(realT)-0.5.*log(realden)).*realden.*realT.^-1.5.*t0./(mu*1836);

%  sbdel() multiplies a redundant tau, which is eliminated by the tau in the denominator
jz(2:end-1,2:end-1,2:end-1) = calc .* ((sbdel(pei)-deni(2:end-1,2:end-1,2:end-1).*sbdel(phi))./(tau.*nustar));

% jz = sbcznn(jz);
%     jzest = sbcxy(jzest);  %  jz(:,:,1) and jz(:,:,end) are initially 0 and are never changed
ve(2:end-1,2:end-1,2:end-1) = calc .* (vii(2:end-1,2:end-1,2:end-1) - jz(2:end-1,2:end-1,2:end-1)./deni(2:end-1,2:end-1,2:end-1));


