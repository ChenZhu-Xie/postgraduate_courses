x = -1.5:0.001:1.5 ;
y = atanh(x) ;
plot(x,y,['--',color(1)]) ;

hold on;

x = -1.5:0.001:1.5 ;
y = x.^3 ;
plot(x,y,['--',color(1)]) ;