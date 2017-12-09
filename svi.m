function svi()
global f fi calc vi vii pei deni
persistent work para fxy dif2t

para = sbdel(pei)./deni(2:end-1,2:end-1,2:end-1) + vii(2:end-1,2:end-1,2:end-1) .* sbdel(vii);
fxy = convect(vii);
dif2t = dif2(vi);
work = f*vi(2:end-1,2:end-1,2:end-1) + fi*vii(2:end-1,2:end-1,2:end-1) ...
    + calc .* (-fxy - para + dif2t);
if f < 0.6
    vi = vii;
end
vii(2:end-1,2:end-1,2:end-1) = work;
vii = sbcznn(vii);


