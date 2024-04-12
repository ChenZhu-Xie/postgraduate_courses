% Sinc 函数自带 pi，所以要使用 数学形式 而非 信息光学形式的 sinc函数时，需要 除以pi
x = -2*pi:pi/100:2*pi;
y = sinc(x);
plot(x,y);
title("sinc函数")
xlabel("x")
ylabel("sinc(x)")
axis([-3*pi 3*pi -2 2])
grid on
grid minor
