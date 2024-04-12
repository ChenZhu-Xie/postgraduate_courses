n2 = 1.515 ;
epsilon1 = -17.3 + 0.68i ;
lam = 632.8 ;
k0 = 2*pi/lam ;
d = 45 ;
n0 = 1 ;
thetadu = 0:0.01:90 ;
theta = thetadu/180*pi ;


a2 = k0*n2*cos(theta)*i ;
a1 = k0*(n2^2*sin(theta).^2-epsilon1).^0.5 ;
a0 = k0*(n2^2*sin(theta).^2-n0^2).^0.5 ;
e2 = n2^2/epsilon1 ;
e1 = epsilon1/n0^2 ;

Hi = ((a2+e2*a1).*(a1+e1*a0).*exp(a1*d) + (a2-e2*a1).*(a1-e1*a0).*exp(-a1*d))./(4*a2.*a1) ;
Hb = 1./Hi ;
E0x = abs(Hb*e2*e1) ;
E0z = E0x*abs(a0/a2) ;

figure() ;
plot(thetadu,E0x) ;
title("E_{0x}") ;
xlabel("»Î…‰Ω«\theta") ;
ylabel("E_{0x}(\theta)") ;
axis([0 90 0 180]) ;
grid on ;
grid minor ;

figure();
plot(thetadu,E0z);
title("E_{0z}") ;
xlabel("»Î…‰Ω«\theta") ;
ylabel("E_{0z}(\theta)") ;
axis([0 90 0 180]) ;
grid on ;
grid minor ;
