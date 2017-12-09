close all;
nts0 = 250;
nts1 = nts;
tmp1 = find(x>0);
tmp2 = find(x<Rho);
rx0 = tmp1(1);
rx1 = tmp2(end);
clear tmp1 tmp2
r = x(rx0:rx1);
nr = length(r);

phiprf = zeros(nts1-nts0+1, nr);
peprf = phiprf;
densprf = phiprf;
vethtprf = phiprf;
verprf = phiprf;

for nt = nts0:nts1
    fid = (['dat', sprintf('%4.4d', nt), '.mat']);
    if ~exist(fid, 'file')
        error(['Cannot find file: ', fid])
    end
    load (fid, 'phi', 'densi', 'pei', 'vex', 'vey');
    phiprf(nt-nts0+1,:) = phi(ceil(ny/2), rx0:rx1, zdiag);
    peprf(nt-nts0+1,:) = pei(ceil(ny/2), rx0:rx1, zdiag);
    densprf(nt-nts0+1,:) = densi(ceil(ny/2), rx0:rx1, zdiag);
    vethtprf(nt-nts0+1,:) = vey(ceil(ny/2), rx0:rx1, zdiag);
    verprf(nt-nts0+1,:) = vex(ceil(ny/2), rx0:rx1, zdiag);
end

vethtmean = mean(vethtprf, 1);
vermean = mean(verprf, 1);
vethtpert = phiprf;
verpert = phiprf;
phimean = mean(phiprf, 1);
pemean = mean(peprf, 1);
densmean = mean(densprf, 1);
Rnld = mean(vethtpert .* verpert, 1);  % Renolds stress
for ir = 1:nr
	vethtpert(:, ir) = vethtprf(:, ir) - vethtmean(ir) .* ones(nts1-nts0+1, 1);
	verpert(:, ir) = verprf(:, ir) - vermean(ir) .* ones(nts1-nts0+1, 1);
end

figure;  set(gcf, 'position', [0,40,2050,955]);
subplot(2,3,1);  plot(r*rhos, Tref.*phimean);
title('Potential');  xlabel('r/cm');
ylabel('$\phi/V$', 'interpreter', 'latex');

subplot(2,3,2);  plot(r*rhos, Tref.*pemean);
title('Temperature');  xlabel('r/cm');
ylabel('T/eV');

subplot(2,3,3);  plot(r*rhos, denref.*densmean);
title('Density');  xlabel('r/cm');
ylabel('n/cm^-3');

subplot(2,3,4); plot(r*rhos, vethtmean);
title('Azimuzal EXB Velocity'); xlabel('r/cm');
ylabel('$V_{\theta}/cs$', 'interpreter', 'latex');

subplot(2,3,5); plot(r*rhos, cs.*vethtmean);
title('Azimuzal EXB Velocity'); xlabel('r/cm');
ylabel('$V_{\theta}/cm*s^-1$', 'interpreter', 'latex');

subplot(2,3,6); plot(r*rhos, cs^2.*Rnld);
title('Renolds Stress'); xlabel('r/cm');
ylabel('$<\tilde{V_r}\tilde{V_{\theta}}>/cm^2s^{-2}$', 'interpreter', 'latex');

print(gcf, '-dpng', 'turbulence_profile.png')
