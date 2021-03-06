function diagnose(idiagnose)
global p pe den vi w jz ve Te phi vEx vEy
global deni vii pei densi wi phi jz vex vey visual savedata xd yd zd denref Tref cs rhos
persistent xdiag zdiag

if isempty(xdiag)
    xdiag = ceil(length(xd)/2.0);
    zdiag = ceil(length(zd)/2.0);
end

if savedata
    fid = ['dat', sprintf('%4.4d', nt)];
    save(fid, 'densi', 'vii', 'pei', 'wi', 'phi', 'jz', 'vex', 'vey');
end

if visual
    close all;
    
    figure; set(gcf, 'position', [520,40,1400,955]);
    
    subplot(4,4,1); pcolor(xd,yd,denref*densi(:,:,zdiag));
    colormap jet; colorbar; shading interp;
    title('Density/cm^-3'); xlabel('x/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,2); pcolor(xd,yd,cs*vii(:,:,zdiag));
    colormap jet; colorbar; shading interp;
    title('Ion parallel velocity/cm*s^-1'); xlabel('x/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,3);	pcolor(xd,yd,Tref*pei(:,:,zdiag)./deni(:,:,zdiag));
    colormap jet; colorbar; shading interp;
    title('Temperature/eV'); xlabel('x/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,4); pcolor(xd,yd,Tref/rhos^2*wi(:,:,zdiag));
    colormap jet; colorbar; shading interp;
    title('Vorticity/V*cm^-2'); xlabel('x/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,5); pcolor(xd,yd,Tref*phi(:,:,zdiag));
    colormap jet; colorbar; shading interp;
    title('Potential/V'); xlabel('x/cm'); ylabel('y/cm'); drawnow;
    
%     subplot(4,4,6); pcolor(xd,yd,(1.602e-19)*cs*denref*1e4*jz(:,:,zdiag));
%     colormap jet; colorbar; shading interp;
%     title('jz/A'); xlabel('x/cm'); ylabel('y/cm'); drawnow;
    subplot(4,4,6); pcolor(xd,yd,cs*jz(:,:,zdiag));
    colormap jet; colorbar; shading interp;
    title('jz/cm*s^-1'); xlabel('x/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,7); pcolor(xd,yd,cs*vex(:,:,zdiag));
    colormap jet; colorbar; shading interp;
    title('vex/cm*s^-1'); xlabel('x/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,8); pcolor(xd,yd,cs*vey(:,:,zdiag));
    colormap jet; colorbar; shading interp;
    title('vey/cm*s^-1'); xlabel('x/cm'); ylabel('y/cm'); drawnow;
    
    
    subplot(4,4,9); pcolor(zd,yd,squeeze(denref*densi(:,xdiag,:)));
    colormap jet; colorbar; shading interp;
    title('Density/cm^-3'); xlabel('z/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,10); pcolor(zd,yd,squeeze(cs*vii(:,xdiag,:)));
    colormap jet; colorbar; shading interp;
    title('Ion parallel velocity/cm*s^-1'); xlabel('z/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,11);	pcolor(zd,yd,squeeze(Tref*pei(:,xdiag,:)./deni(:,xdiag,:)));
    colormap jet; colorbar; shading interp;
    title('Temperature/eV'); xlabel('z/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,12); pcolor(zd,yd,squeeze(Tref/rhos^2*wi(:,xdiag,:)));
    colormap jet; colorbar; shading interp;
    title('Vorticity/V*cm^-2'); xlabel('z/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,13); pcolor(zd,yd,squeeze(Tref*phi(:,xdiag,:)));
    colormap jet; colorbar; shading interp;
    title('Potential/V'); xlabel('z/cm'); ylabel('y/cm'); drawnow;
    
%     subplot(4,4,13); pcolor(zd,yd,squeeze((1.602e-19)*cs*denref*1e4*jz(:,xdiag,:)));
%     colormap jet; colorbar; shading interp;
%     title('jz/A'); xlabel('z/cm'); ylabel('y/cm'); drawnow;
    subplot(4,4,14); pcolor(zd,yd,squeeze(cs*jz(:,xdiag,:)));
    colormap jet; colorbar; shading interp;
    title('jz/cm*s^-1'); xlabel('z/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,15); pcolor(zd,yd,squeeze(cs*vex(:,xdiag,:)));
    colormap jet; colorbar; shading interp;
    title('vex/cm*s^-1'); xlabel('z/cm'); ylabel('y/cm'); drawnow;
    
    subplot(4,4,16); pcolor(zd,yd,squeeze(cs*vey(:,xdiag,:)));
    colormap jet; colorbar; shading interp;
    title('vey/cm*s^-1'); xlabel('z/cm'); ylabel('y/cm'); drawnow;
    
    if savedata
        print(gcf, '-dpng', ['orz', sprintf('%4.4d', nt), '.png'])
    end
end
