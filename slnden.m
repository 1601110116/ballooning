function slnden( )
global f fi calc deni lnden lndeni ve deninjct
persistent work para fxy dif2t

para = sbdel(ve) + ve(2:end-1,2:end-1,2:end-1) .* sbdel(lndeni);
fxy = convect(lndeni);
dif2t = dif2(lnden);
work = f*lnden(2:end-1,2:end-1,2:end-1) + fi*lndeni(2:end-1,2:end-1,2:end-1) ...
    + calc .* (-fxy - para + dif2t);
if f < 0.6
	lnden = lndeni;
end
lndeni(2:end-1,2:end-1,2:end-1) = work;
deni(2:end-1,2:end-1,2:end-1) = exp(lndeni(2:end-1,2:end-1,2:end-1)) + deninjct;
deni = sbcznn(deni);
lndeni = log(deni);

