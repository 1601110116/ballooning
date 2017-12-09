global Rho dtx dty dtz deninjct peinjct densinjct kx1 ky1 ...
    vi vii pei densi w wi lnpe lnpei lndens lndensi ve jz deni phi ...
    f fi nts vex vey nx0 ny0 nz0 tau calc pe dens


% FFT preparation
fxmax = 1/dx;
kx = 2*pi*linspace(0,fxmax,nx0);
halfx = ceil(nx0/2);
for i = 2:halfx
    kx(nx0-halfx+i) = -kx(halfx+2-i);
end
fymax = 1/dy;
ky = 2*pi*linspace(0,fymax,ny0);
halfy = ceil(ny0/2);
for i = 2:halfy
    ky(ny0-halfy+i) = -ky(halfy+2-i);
end
[kx1,ky1] = meshgrid(kx,ky,z(2:end-1));

%  Initial conditions
deninjct = zeros(ny0,nx0,nz0);
peinjct = zeros(ny0,nx0,nz0);
calc = zeros(ny0,nx0,nz0);
dtx = zeros(ny0,nx0,nz0);
dty = zeros(ny0,nx0,nz0);
for i = 1:nx0
    for j = 1:ny0
        r = sqrt(x(i+1)^2+y(j+1)^2);
        if r < Rho
            calc(j,i,:) = ones(1,1,nz0);
        end
        if r < rdif
            dtx(j,i,:) = dif_in * ones(1,1,nz0);
            dty(j,i,:) = dif_in * ones(1,1,nz0);
        else
            dtx(j,i,:) = dif_out * ones(1,1,nz0);
            dty(j,i,:) = dif_out * ones(1,1,nz0);
        end
    end
end
dtx = tau * dx2 * dtx;
dty = tau * dy2 * dty;
dtz = difz_in * ones(ny0,nx0,nz0);
dtz(:,:,1:nzdif) = difz_out * ones(ny0,nx0,nzdif);
dtz(:,:,end-nzdif+1:end) = difz_out * ones(ny0,nx0,nzdif);
dtz = dtz * tau * dz2;
if restart == 0
    wi = zeros(ny,nx,nz);
    deni=wi; vii=wi; pei=wi; phi=wi; jz=wi; vex=wi; vey=wi; 
    for i = 1:nx0
        for j = 1:ny0
            for m = 1:nz0
                r = sqrt(x(i+1)^2+y(j+1)^2);
                %                 den(j,i,m) = 0.5*(1-tanh((r-intdenpdst)/intdenwdth)) + pert*(rand+1e4);
                deni(j+1,i+1,m+1) = 1;
%                 pei(j+1,i+1,m+1) = 0.5*(1-tanh((r-intpepdst)/intpewdth)) + pert*rand*calc(j,i,m)+0.001;
                pei(j+1,i+1,m+1) = pert*rand*calc(j,i,m)+0.001;
            end
        end
    end
    deni = sbcxy(deni); deni = sbcznn(deni);
    pei = sbcxy(pei); pei = sbcznn(pei);
    densi = pei;
elseif (restart ==1)
    load rest.mat
    deni = ones(ny, nx, nz);
end
ve = vii - jz./deni;
lndeni = log(deni);  lnpei = log(pei); pe = pei; 
lnden = lndeni;  lnpe = lnpei;  vi = vii;  w = wi;
lndensi = log(densi);  dens = densi;  lndens = lndensi;


%  Source
% if enable_source
%     deninjctx = densrc*normpdf(x(2:end-1),densrcctr,densrcsig);
%     deninjcty = densrc*normpdf(y(2:end-1)',densrcctr,densrcsig);
%     tmpden = tau*deninjcty*deninjctx;
%     peinjctx = pesrc*normpdf(x(2:end-1),pesrcctr,pesrcsig);
%     peinjcty = pesrc*normpdf(y(2:end-1)',pesrcctr,pesrcsig);
%     tmppe = tau*peinjcty*peinjctx;
%     for m = 1:nz0
%         deninjct(:,:,m) = tmpden;
%         peinjct(:,:,m) = tmppe;
%     end
%     clear peinjctx; clear peinjcty;
%     clear deninjctx; clear deninjcty;
% end

if enable_source
    for i = 1:nx0
        for j = 1:ny0
            r = sqrt(x(i+1)^2+y(j+1)^2);
            peinjct(j,i,:) = 6.5e-4 * 0.5 * (1-tanh((r-intpepdst)/intpewdth)) .* ones(1,1,nz0);
            densinjct(j,i,:) = 6.5e-4 * 0.5 * (1-tanh((r-intpepdst)/intpewdth)) .* ones(1,1,nz0);
        end
    end
end



for nt=1:nts
    disp(['step ', num2str(nt), ' of ', num2str(nts)])
    for ntt=1:ntp
        f = 0.5;  fi = 0.5;
        %         sden( )
        slndens( )
        svi( )
        slnpe( )
        sw( )
        spe2d( )        
        f = 1.0; fi = 0.0;
        %         sden( )
        slndens( )
        svi( )
        slnpe( )
        sw( )
        spe2d( )
        done=isfinite(pei(2,2,2));
        if done==0
            error('nan')
        end
    end
    diagnose(nt)
end


