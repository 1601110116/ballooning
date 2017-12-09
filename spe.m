function spe( )
global f fi calc pei ve peinjct pe
persistent work para fxy dif2t

para = 1.667 * pei(2:end-1,2:end-1,2:end-1) .* sbdel(ve) + ve(2:end-1,2:end-1,2:end-1) .* sbdel(pei);
fxy = convect(pei);
dif2t = dif2(pe);
work = f*pe(2:end-1,2:end-1,2:end-1) + fi*pei(2:end-1,2:end-1,2:end-1) ...
    + calc .* (-fxy - para + dif2t + peinjct);
if f < 0.6
    pe = pei;
end
pei(2:end-1,2:end-1,2:end-1) = work;
pei = sbcznn(pei);