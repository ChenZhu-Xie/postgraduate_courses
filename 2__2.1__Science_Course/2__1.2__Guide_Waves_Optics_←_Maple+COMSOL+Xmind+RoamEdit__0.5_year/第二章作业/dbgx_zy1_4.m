clc;clear;

epsilon1 = 2 ;
epsilon2 = -17.3 + 0.68i ;
lam = 632.8 ;
k0 = 2*pi/lam ;
% beta = 3 ;
% k1 = (k0^2*epsilon1-beta^2)^0.5 ;
% a2 = (beta^2-k0^2*real(epsilon2))^0.5 ;
m = 0 ;
right = (epsilon1*real(epsilon2)/(epsilon1+real(epsilon2)))^0.5 ;
color = ['k','r','b','g','m','y','c']

%TE mod
x = 0:0.001:(epsilon1)^0.5 ;
y = (m*pi+2*atan((x.^2-real(epsilon2)).^0.5./(epsilon1-x.^2).^0.5))./(epsilon1-x.^2).^0.5 ;

figure();
TE0 = plot(x,y,['--',color(1)]) ;
text(round(length(x)/2)*0.001+120*0.001,y(round(length(x)/2)+120)+1.4,num2str(m),'FontSize',15,'Color',color(m+1),'FontWeight','Light') ;
title("双层金属包覆介质波导的色散曲线",'fontsize',30)
xlabel("β/k0")
ylabel("k0d")
axis([0 1.5*right 0 30])
grid on
grid minor

hold on;

for m=1:4
    x = 0:0.001:(epsilon1)^0.5 ;
    y = (m*pi+2*atan((x.^2-real(epsilon2)).^0.5./(epsilon1-x.^2).^0.5))./(epsilon1-x.^2).^0.5 ;
    plot(x,y,['--',color(m+1)]) ;
    text(round(length(x)/2)*0.001+120*0.001,y(round(length(x)/2)+120)+1.4,num2str(m),'FontSize',15,'Color',color(m+1),'FontWeight','Light') ;
    x = 0:0.001:(epsilon1)^0.5 ;
    y = (m*pi+2*atan(epsilon1/real(epsilon2)*(x.^2-real(epsilon2)).^0.5./(epsilon1-x.^2).^0.5))./(epsilon1-x.^2).^0.5 ;
    plot(x,y,[color(m+1)]) ;
    text(round(length(x)/2)*0.001,y(round(length(x)/2))+1.4,num2str(m),'FontSize',15,'Color',color(m+1),'FontWeight','Light') ;
end

plot([epsilon1^0.5,epsilon1^0.5],[0,30],'c','linewidth',2) ;
text(epsilon1^0.5-0.03,0-1.4,'$$\sqrt{\varepsilon_1}$$','interpreter','latex','FontSize',15,'Color','c','FontWeight','Bold') ;

% x = (epsilon1)^0.5:0.001:right ;
% y = (m*pi+2*atan(epsilon1/real(epsilon2)*(x.^2-real(epsilon2)).^0.5./(epsilon1-x.^2).^0.5))./(epsilon1-x.^2).^0.5 ;
% plot(x,y,[color(2)]) ;

x = (epsilon1)^0.5:0.001:right ;
y = -2*atanh(real(epsilon2)/epsilon1*(x.^2-epsilon1).^0.5./(x.^2-real(epsilon2)).^0.5)./(x.^2-epsilon1).^0.5 ;
plot(x,y,[color(2)]) ;

% x = right:0.001:1.5*right ;
% y = (m*pi+2*atan(epsilon1/real(epsilon2)*(x.^2-real(epsilon2)).^0.5./(epsilon1-x.^2).^0.5))./(epsilon1-x.^2).^0.5 ;
% plot(x,y,[color(1)]) ;

x = right:0.001:1.5*right ;
y = -2*atanh(epsilon1/real(epsilon2)*(x.^2-real(epsilon2)).^0.5./(x.^2-epsilon1).^0.5)./(x.^2-epsilon1).^0.5 ;
TM0 = plot(x,y,[color(1)]) ;
text(right+round(length(x)/2)*0.001,y(round(length(x)/2))+1.4,num2str(0),'FontSize',15,'Color',color(0+1),'FontWeight','Light') ;

plot([right,right],[0,30],'color',[0.6 0.6 0.3],'linewidth',2) ;
text(right-0.07,0-1.4-0.5,'$$\sqrt{\frac{\varepsilon_1\varepsilon_2}{\varepsilon_1+\varepsilon_2}}$$','interpreter','latex','FontSize',15,'Color',[0.6 0.6 0.3],'FontWeight','Bold') ;

text(epsilon1^0.5-1,20,'导模区','FontSize',30,'Color','c','FontWeight','Bold') ;
text(right-0.07,20,'表面模区','FontSize',30,'Color','c','FontWeight','Bold') ;

legend([TE0 TM0],'TE模','TM模','fontsize',30) ;

