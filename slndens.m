function slndens( )
global f fi calc densi lndens lndensi ve densinjct
persistent work para fxy dif2t

para = sbdel(ve); %+ ve(2:end-1,2:end-1,2:end-1) .* sbdel(lndensi);
fxy = convect(lndensi);
dif2t = dif2(lndens);
work = f*lndens(2:end-1,2:end-1,2:end-1) + fi*lndensi(2:end-1,2:end-1,2:end-1) ...
    + calc .* (-fxy - para + dif2t);
if f < 0.6
	lndens = lndensi;
end
lndensi(2:end-1,2:end-1,2:end-1) = work;
densi(2:end-1,2:end-1,2:end-1) = exp(lndensi(2:end-1,2:end-1,2:end-1)) + densinjct;
densi = sbcznn(densi);
lndensi = log(densi);

