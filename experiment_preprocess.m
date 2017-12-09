global dx1p5 dy1p5 dyt1p5 dxt1p5 dzt1p5 denref Tref mu t0 ...
    cs rhos xd yd zd

%  Units
omec = 9.58e3*B/mu;  %  ion gyrofrequency in Hz
cs = 9.79e5*(Tref/mu)^0.5;  %  ion sound speed in cm/s
rhos = cs/omec;  %  ion gryoradius in cm
t0 = Rho/cs;  %  t0 in s
disp(['Gyroradius is ',num2str(rhos),' cm'])
disp(['Time step is ',num2str(t0*tau),' s'])
cm = 1/rhos;  %  centimeter in gyroradius
sec = 1/t0;  %  second in t0

%  Calculate source
rfpow = rfpow / (alz*1.602e-22);  %  total power injection per cm in z direction in eV/(cm*s£©
densrcmax = rfpow/15.77;
disp(['Maximum density source is ',num2str(densrcmax),' cm^-1s^-1 '])
if densrc > densrcmax
    error(['densrc must be less than ',num2str(densrcmax),' cm^-1s^-1 !']);
end

denpow = densrc * 15.77;  %  ionization energy rate per cm in z direction in eV/(cm*s)
pesrc = rfpow - denpow;  %  p source in (eV/cm^3)*(cm^2/s)
pesrc = pesrc/(Tref*denref)*(cm^2/sec);  %  in Tref*denref*(rhos^2/t0)
densrc = densrc/denref*(cm^2/sec);  %%  in denref*(rhos^2/t0)
densrcsig = densrcwdth/3 * cm;
pesrcsig = pesrcwdth/3 * cm;
densrcmu = densrcctr * cm;
pesrcmu = pesrcctr * cm;

%  Normalization
alz = alz/Rho;  %  parallel length is normalized to Rho
Rho = Rho*cm;  %  a in rho_s
alx = alx*cm;
aly = aly*cm;
intdenpdst = intdenpdst*cm;
intdenwdth = intdenwdth*cm;
intpepdst = intpepdst*cm;
intpewdth = intpewdth*cm;

%  Grid
x = 0:dx:alx;
y = 0:dy:aly;
z = linspace(0,alz,nz);
nx = length(x);
ny = length(y);
alx = x(nx);
aly = y(ny);
nx0 = nx - 2;  %  the first and last elements are used to implement boundary conditions
ny0 = ny - 2;
x = x-0.5*alx;
y = y-0.5*aly;

dz = alz/(nz-1);
nz0 = nz - 2;


% Constants
dx2 = 1/dx^2;
dy2 = 1/dy^2;
dz2 = 1/dz^2;
% dtx=dif*tau*dx2;
% dty=dif*tau*dy2;
% dtz=difz*tau*dz2;
dx1p5 = 1/(2*dx);
dy1p5 = 1/(2*dy);
dzt1p5=tau/(2*dz);
dxt1p5=tau/(2*dx);
dyt1p5=tau/(2*dy);


%  Drawing preparation
zdiag = floor(nz/2);  %zdiag = 6;
xdiag = ceil(nx/2);
xd = x.*rhos;
yd = y.*rhos;
zd = Rho*rhos*z;