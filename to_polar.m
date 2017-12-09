global deni vii pei wi phi jz vex vey xd yd zd denref Tref cs rhos


for nt = 100:100

    fig = figure;% set(gcf, 'position', [520,40,1400,955]);
    pcolor(xd,yd,cs*vex(:,:,zdiag));
    colormap jet; colorbar; shading interp;
    title('vex/cm*s^-1'); xlabel('x/cm'); ylabel('y/cm'); drawnow;

    
end