clear ,clc;

format long

x=(0:0.01:20)';

y_0=besselj(0,x);

y_1=besselj(1,x);

y_2=besselj(2,x);

plot(x,y_0,x,y_1,x,y_2);grid on;

axis([0,20,-1,1]);

title('0阶、一阶、二阶第一类贝塞尔函数曲线图');

xlabel('Variable X');

ylabel('Variable Y');