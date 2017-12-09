%   This script analysis existing data in polar coordinate

global deni vii pei wi phi jz vex vey xd yd zd denref Tref cs rhos ...
    xc yc zc xp yp zp rp thtp



%   Parameter setting
nr = floor(nx/2);
ntht = 2*nr;

%   Initialization
vethtmeanm = zeros(nr, 1);
msrtvm = zeros(nr, 1);
trsm = zeros(nr, 1);

% Build Grid
[xc, yc, zc] = meshgrid(x, y, z);
r = linspace(0, alx/2, nr);
tht = linspace(0, 2*pi, ntht);
[thtp, rp, zp] = meshgrid(tht, r, z);
%  xp is the x at polar grid points
[xp, yp, zp] = pol2cart(thtp, rp, zp);

%  Video preparation
writerObj = VideoWriter('analysis', 'MPEG-4');
writerObj.FrameRate = 5; 
writerObj.Quality = 80;
open(writerObj);

for nt = 150:1000
    fid = (['dat', sprintf('%4.4d', nt), '.mat']);
    if ~exist(fid, 'file')
        error(['Cannot find file: ', fid])
    end
    load (fid)
    vexp = grid2pol(vex);
    veyp = grid2pol(vey);
    [vethtp, verp] = vec2pol(vexp, veyp);
    %  vethmean is the mean \theta direction EXB drift velocity at the
    %  plane of nz = zdiag in cylindrical grid
    [~, vethtmean] = meshgrid(tht, mean(vethtp(:, :, zdiag), 2));
    vethtpert = vethtp(:, :, zdiag) - vethtmean;
    [~, vermean] = meshgrid(tht, mean(verp(:, :, zdiag), 2));
    verpert = verp(:, :, zdiag) - vermean;
    %   msrtv means mean-squared radial turbulent velocity
    msrtv = mean(verpert.^2, 2);
    %   trs means total Reynolds Stress
    trs = mean(verpert .* vethtpert, 2);
    
    vethtmeanm = vethtmeanm + vethtmean(:,1);
    msrtvm = msrtvm + msrtv;
    trsm = trsm + trs;
    
    close all;
    fig = figure;  set(gcf, 'position', [520,40,1400,955]);
    title(['nt = ', num2str(nt)]);
    
    subplot(3,3,1); plot(r, vethtmean(:,1));
    xlabel('r/\rho_s');
    ylabel('$<V_{\theta}>$', 'interpreter', 'latex');
    
    subplot(3,3,2); plot(r, msrtv);
    xlabel('r/\rho_s');
    ylabel('$<\tilde{V_r}^2>$', 'interpreter', 'latex');
    
    subplot(3,3,3); plot(r, trs);
    xlabel('r/\rho_s');
    ylabel('$<\tilde{V_r}\tilde{V_{\theta}}>$', 'interpreter', 'latex');
    
    subplot(3,3,4); pcolor(xp(:,:,zdiag), yp(:,:,zdiag), verpert);
    colormap jet; colorbar; shading interp;
    title('$\tilde{V_r}$', 'interpreter', 'latex');
    
    subplot(3,3,5); pcolor(xp(:,:,zdiag), yp(:,:,zdiag), vethtpert);
    colormap jet; colorbar; shading interp;
    title('$\tilde{V_{\theta}}$', 'interpreter', 'latex');
    
    if savedata
        print(gcf, '-dpng', ['analysis', sprintf('%4.4d', nt), '.png'])
    end
    writeVideo(writerObj, getframe(fig));
end
close(writerObj)
figure;
subplot(2,2,1); plot(r, vethtmeanm);
xlabel('r/\rho_s');
ylabel('$<V_{\theta}>$', 'interpreter', 'latex');

subplot(2,2,2);plot(r, msrtvm);
xlabel('r/\rho_s');
ylabel('$<\tilde{V_r}^2>$', 'interpreter', 'latex');

subplot(2,2,3); plot(r, trsm);
xlabel('r/\rho_s');
ylabel('$<\tilde{V_r}\tilde{V_{\theta}}>$', 'interpreter', 'latex');