% Sinc �����Դ� pi������Ҫʹ�� ��ѧ��ʽ ���� ��Ϣ��ѧ��ʽ�� sinc����ʱ����Ҫ ����pi
x = -2*pi:pi/100:2*pi;
y = sinc(x);
plot(x,y);
title("sinc����")
xlabel("x")
ylabel("sinc(x)")
axis([-3*pi 3*pi -2 2])
grid on
grid minor
