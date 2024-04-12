clc;clear;

n1 = 1.08 ;
n2 = 1 ;
lam = 1550*10^(-9) ;
k0 = 2*pi/lam ;
l = 1;

% f = BesselJ(1, h*a)/(h*a*BesselJ(0, h*a)) + BesselK(1, q*a)/(q*a*BesselK(0, q*a))
% f = @(a,beta)BesselJ(1, sqrt(k0^2*n1^2-beta^2)*a)/(sqrt(k0^2*n1^2-beta^2)*a*BesselJ(0, sqrt(k0^2*n1^2-beta^2)*a)) + BesselK(1, sqrt(beta^2-k0^2*n2^2)*a)/(sqrt(beta^2-k0^2*n2^2)*a*BesselK(0, sqrt(beta^2-k0^2*n2^2)*a))
f = @(a,beta)besselj(1, (k0^2*n1^2-beta.^2).^0.5.*a)./((k0^2*n1^2-beta.^2).^0.5.*a.*besselj(0, (k0^2*n1^2-beta.^2).^0.5.*a)) + besselk(1, (beta.^2-k0^2*n2^2).^0.5.*a)./((beta.^2-k0^2*n2^2).^0.5.*a.*besselk(0, (beta.^2-k0^2*n2^2).^0.5.*a));
fimplicit(f, [0, 4.5*10^(-6),k0*n2,k0*n1],'r','linewidth',0.5)

hold on;

% syms x
% diff(besselk(l,x),x)
% subs(diff(besselk(l,x),x),x,1)

% f1 = @(a,beta)besselj(l, (k0^2*n1^2-beta.^2).^0.5.*a)./((k0^2*n1^2-beta.^2).^0.5.*a.*besselj(l, (k0^2*n1^2-beta.^2).^0.5.*a)) - (n1^2+n2^2)/(2*n1^2)*subs(diff(besselk(l, x),x),x,(beta.^2-k0^2*n2^2).^0.5.*a)./((beta.^2-k0^2*n2^2).^0.5.*a.*besselk(l, (beta.^2-k0^2*n2^2).^0.5.*a))...
%     -((l./(k0^2-beta.^2).*a.^2-((n1^2+n2^2)/(2*n1^2))^2*(subs(diff(besselk(l, x),x),x,(beta.^2-k0^2*n2^2).^0.5.*a)./((beta.^2-k0^2*n2^2).^0.5.*a.*besselk(l, (beta.^2-k0^2*n2^2).^0.5.*a))).^2+l^2/n1^2.*(beta/k0).^2.*(1./(beta.^2-k0^2*n2^2)./a.^2+1./(k0^2*n1^2-beta.^2)./a.^2).^2).^0.5);
f1 = @(a,beta)besselj(l, (k0^2*n1^2-beta.^2).^0.5.*a)./((k0^2*n1^2-beta.^2).^0.5.*a.*besselj(l, (k0^2*n1^2-beta.^2).^0.5.*a)) - (n1^2+n2^2)/(2*n1^2)*(- besselk(l-1, (beta.^2-k0^2*n2^2).^0.5.*a) - l*besselk(l, (beta.^2-k0^2*n2^2).^0.5.*a))./((beta.^2-k0^2*n2^2).^0.5.*a.*besselk(l, (beta.^2-k0^2*n2^2).^0.5.*a))...
    -((l./(k0^2-beta.^2).*a.^2-((n1^2-n2^2)/(2*n1^2))^2*((- besselk(l-1, (beta.^2-k0^2*n2^2).^0.5.*a) - l*besselk(l, (beta.^2-k0^2*n2^2).^0.5.*a))./((beta.^2-k0^2*n2^2).^0.5.*a.*besselk(l, (beta.^2-k0^2*n2^2).^0.5.*a))).^2+l^2/n1^2.*(beta/k0).^2.*(1./(beta.^2-k0^2*n2^2)./a.^2+1./(k0^2*n1^2-beta.^2)./a.^2).^2).^0.5);
fimplicit(f1, [0, 4.5*10^(-6),k0*n2,k0*n1],'r','linewidth',0.5)