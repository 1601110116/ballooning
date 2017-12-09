function slnpe( )
global f fi calc pei lnpe lnpei ve peinjct
persistent work para fxy dif2t

para = 1.667 * sbdel(ve);% + ve(2:end-1,2:end-1,2:end-1) .* sbdel(lnpei);
fxy = convect(lnpei);
dif2t = dif2(lnpe);
work = f*lnpe(2:end-1,2:end-1,2:end-1) + fi*lnpei(2:end-1,2:end-1,2:end-1) ...
    + calc .* (-fxy - para + dif2t);
if f < 0.6
    lnpe = lnpei;
end
lnpei(2:end-1,2:end-1,2:end-1) = work;
pei(2:end-1,2:end-1,2:end-1) = exp(lnpei(2:end-1,2:end-1,2:end-1)) + peinjct;
pei = sbcznn(pei);
lnpei = log(pei);

