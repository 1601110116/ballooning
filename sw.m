function sw( )
global f fi calc w wi deni jz
persistent work para fxy dif2t

para = sbdel(jz)./deni(2:end-1,2:end-1,2:end-1);
fxy = convect(wi);
dif2t = dif2(w);
work = f*w(2:end-1,2:end-1,2:end-1) + fi*wi(2:end-1,2:end-1,2:end-1) ...
    + calc .* (-fxy + para + dif2t);
if f < 0.6
    w = wi;
end
wi(2:end-1,2:end-1,2:end-1) = work;
wi = sbcznn(wi);

