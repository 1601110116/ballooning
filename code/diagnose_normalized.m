function diagnose_normalized(idiagnose, nt_per_diagnose)
global p pe den vi w jz ve Te phi vEx vEy limiter_place dz x y z dt ...
    nx_LCFS savedata visual
persistent xdiag ydiag zdiag p_pert pe_pert den_pert phi_pert

% This function draws the contours of the simulated quantities at run time
%  diagnose the y-z plane at x = (xdiag-2)*dx
%  diagnose the x-y plane at z = (zdiag-2)*dx
%
% boundary    time-advanced area
% _______  ____________________________
%     .       .       .       .       . ...
% x(1)=-dx  x(2)=0  x(3)=dx

if isempty(xdiag)
	xdiag = nx_LCFS;
	ydiag = floor(length(y)/2);
	zdiag = round(0.25*limiter_place/dz) + 1;  % just at outer mid-plane
end

if savedata
	datafile = ['dat', sprintf('%4.4d', idiagnose)];
	save(datafile, 'p', 'pe', 'den', 'vi', 'w', 'jz', 've', 'Te', 'phi', ...
		'vEx', 'vEy');
end

if visual
	close all;
	t = idiagnose * dt * nt_per_diagnose;
	%figure;  set(gcf, 'position', [520, 40, 1400, 955]);
	figure; set(gcf, 'Position', get(0, 'ScreenSize'));

	subplot(6,5,1); pcolor(y, x, p(:,:,zdiag));
	colormap jet; colorbar; shading interp;
	title('$$p_{i}/\left(T_{0}n_{0}\right)$$', 'interpreter', 'latex');
	ylabel('$$x/\rho_{s}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,2); pcolor(y, x, pe(:,:,zdiag));
	colormap jet; colorbar; shading interp;
	title('$$p_{e}/\left(T_{0}n_{0}\right)$$', 'interpreter', 'latex');
	ylabel('$$x/\rho_{s}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	pe_pert = get_pert(pe);
	subplot(6,5,3); pcolor(y, x, pe_pert(:,:,zdiag));
	colormap jet; colorbar; shading interp;
	title('$$\tilde{p_{e}}/\left(n_{0}T_{0}\right)$$', 'interpreter', 'latex');
	ylabel('$$x/\rho_{s}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,4); pcolor(y, x, vi(:,:,zdiag));
	colormap jet; colorbar; shading interp;
	title('$$v_{\parallel i}/c_{s0}$$', 'interpreter', 'latex');
	ylabel('$$x/\rho_{s}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,5); pcolor(y, x, w(:,:,zdiag));
	colormap jet; colorbar; shading interp;
	title('$$w/\left(n_{0}e\right)$$', 'interpreter', 'latex');
	ylabel('$$x/\rho_{s}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,6); pcolor(y, x, jz(:,:,zdiag));
	colormap jet; colorbar; shading interp;
	title('$$j_{\parallel}/\left(en_{0}c_{s0}\right)$$', 'interpreter', 'latex');
	ylabel('$$x/\rho_{s}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,7); pcolor(y, x, ve(:,:,zdiag));
	colormap jet; colorbar; shading interp;
	title('$$v_{\parallel e}/c_{s0}$$', 'interpreter', 'latex');
	ylabel('$$x/\rho_{s}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,8); pcolor(y, x, phi(:,:,zdiag));
	colormap jet; colorbar; shading interp;
	title('$$\phi/\left(T_{0}/e\right)$$', 'interpreter', 'latex');
	ylabel('$$x/\rho_{s}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	phi_pert = get_pert(phi);
	subplot(6,5,9); pcolor(y, x, phi_pert(:,:,zdiag));
	colormap jet; colorbar; shading interp;
	title('$$\tilde{\phi}/\left(T_{0}/e\right)$$', 'interpreter', 'latex');
	ylabel('$$x/\rho_{s}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,10); pcolor(y, x, den(:,:,zdiag));
	colormap jet; colorbar; shading interp;
	title('$$n/n_{0}$$', 'interpreter', 'latex');
	ylabel('$$x/\rho_{s}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,11); pcolor(x, z, squeeze(p(:,ydiag,:))');
	colormap jet; colorbar; shading interp;
	title('$$p_{i}/\left(T_{0}n_{0}\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$x/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,12); pcolor(x, z, squeeze(pe(:,ydiag,:))');
	colormap jet; colorbar; shading interp;
	title('$$p_{e}/\left(T_{0}n_{0}\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$x/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,13); pcolor(x, z, squeeze(pe_pert(:,ydiag,:))');
	colormap jet; colorbar; shading interp;
	title('$$\tilde{p_{e}}/\left(n_{0}T_{0}\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$x/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,14); pcolor(x, z, squeeze(vi(:,ydiag,:))');
	colormap jet; colorbar; shading interp;
	title('$$v_{\parallel i}/c_{s0}$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$x/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,15); pcolor(x, z, squeeze(w(:,ydiag,:))');
	colormap jet; colorbar; shading interp;
	title('$$w/\left(n_{0}e\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$x/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,16); pcolor(x, z, squeeze(jz(:,ydiag,:))');
	colormap jet; colorbar; shading interp;
	title('$$j_{\parallel}/\left(en_{0}c_{s0}\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$x/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,17); pcolor(x, z, squeeze(ve(:,ydiag,:))');
	colormap jet; colorbar; shading interp;
	title('$$v_{\parallel e}/c_{s0}$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$x/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,18); pcolor(x, z, squeeze(phi(:,ydiag,:))');
	colormap jet; colorbar; shading interp;
	title('$$\phi/\left(T_{0}/e\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$x/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,19); pcolor(x, z, squeeze(phi_pert(:,ydiag,:))');
	colormap jet; colorbar; shading interp;
	title('$$\tilde{\phi}/\left(T_{0}/e\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$x/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,20); pcolor(x, z, squeeze(den(:,ydiag,:))');
	colormap jet; colorbar; shading interp;
	title('$$n/n_{0}$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$x/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,21); pcolor(y, z, squeeze(p(xdiag,:,:))');
	colormap jet; colorbar; shading interp;
	title('$$p_{i}/\left(T_{0}n_{0}\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,22); pcolor(y, z, squeeze(pe(xdiag,:,:))');
	colormap jet; colorbar; shading interp;
	title('$$p_{e}/\left(T_{0}n_{0}\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,23); pcolor(y, z, squeeze(pe_pert(xdiag,:,:))');
	colormap jet; colorbar; shading interp;
	title('$$\tilde{p_{e}}/\left(n_{0}T_{0}\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,24); pcolor(y, z, squeeze(vi(xdiag,:,:))');
	colormap jet; colorbar; shading interp;
	title('$$v_{\parallel i}/c_{s0}$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,25); pcolor(y, z, squeeze(w(xdiag,:,:))');
	colormap jet; colorbar; shading interp;
	title('$$w/\left(n_{0}e\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,26); pcolor(y, z, squeeze(jz(xdiag,:,:))');
	colormap jet; colorbar; shading interp;
	title('$$j_{\parallel}/\left(en_{0}c_{s0}\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,27); pcolor(y, z, squeeze(ve(xdiag,:,:))');
	colormap jet; colorbar; shading interp;
	title('$$v_{\parallel e}/c_{s0}$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,28); pcolor(y, z, squeeze(phi(xdiag,:,:))');
	colormap jet; colorbar; shading interp;
	title('$$\phi/\left(T_{0}/e\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,29); pcolor(y, z, squeeze(phi_pert(xdiag,:,:))');
	colormap jet; colorbar; shading interp;
	title('$$\tilde{\phi}/\left(T_{0}/e\right)$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel('$$y/\rho_{s}$$', 'interpreter', 'latex');

	subplot(6,5,30); pcolor(y, z, squeeze(den(xdiag,:,:))');
	colormap jet; colorbar; shading interp;
	title('$$n/n_{0}$$', 'interpreter', 'latex');
	ylabel('$$z/\L_{\parallel}$$', 'interpreter', 'latex');
	xlabel(['$$y/\rho_{s}$$', sprintf('\ntime = '), num2str(t), ' $$a/c_{s0}$$'], 'interpreter', 'latex');

	if savedata
		print(gcf, '-dpng', ['normalized', sprintf('%4.4d', idiagnose), '.png']);
	end
end

