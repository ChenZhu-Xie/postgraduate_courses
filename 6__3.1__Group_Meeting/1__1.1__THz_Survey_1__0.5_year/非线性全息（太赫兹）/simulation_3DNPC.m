clc;clear;

%读取结构参数
structure_path = 'Structure';  %修改不同结构的路径
load ([structure_path '\Structure_parameter.mat']);

%设置空间坐标
x = linspace(-A/2,A/2,m);
y = x;
[X,Y] = meshgrid(x,y);
r = sqrt(X.^2+Y.^2);
fi = angle(X+1i*Y);
Z = linspace(0,L,n);

%设置输入基波波长和光场分布、实验温度
lam1 =0.808;lam2 = lam1;T = 25;
lam3 = 1/(1/lam1+1/lam2);
w0 = 80;
A1 = exp(-r.^2/w0^2); A2 = A1;
md = 0.15;  %加工调制深度

%开始计算
[A3,profilex,profiley,d_k] = SSF_FD(A,L,m,n,lam1,lam2,T,A1,A2,structure_path,md);

%绘制结果
%观察面参数
M = 2*m;   %观察像素数
p = 1.2;  %观察范围
L_far = 50e3;  %远场：L_far=传播距离；透镜傅里叶变换：L_far= 焦距。

%观察面坐标
fx = (-M/2:M/2-1).*(1/(M/m*A));
[Fx,Fy] = meshgrid(fx,fx);
x_far = fx*lam3*L_far;

AA3 = padarray(A3,[floor((M-m)/2) floor((M-m)/2)],0,'both');
AA3 = padarray(AA3,[mod(M-m,2) mod(M-m,2)],0,'post');

% %{
%计算远场
A3_far = (M*M)^(-1/2)*fftshift(fft2(fftshift(AA3)));

%绘图
figure();
subplot(1,3,1);imagesc(x,x,abs(A3).^2);title(['{\it{I}}({\it{x{\rm{,}} z}})']);
subplot(1,3,2);imagesc(x_far,x_far,abs(A3_far).^2);title(['{\it{\lambda_{match}} = }' num2str(lam1)]);
axis([-p*lam3*L_far,p*lam3*L_far,-p*lam3*L_far,p*lam3*L_far]);caxis([0,1e-6]);
% subplot(1,3,3);imagesc(x_far,x_far,angle(A3));
% axis([-p*lam3*L_far,p*lam3*L_far,-p*lam3*L_far,p*lam3*L_far]);
subplot(1,3,3);plot(x_far,abs(A3_far(fix(3*m/2+1),:)).^2);
axis([-p*lam3*L_far,p*lam3*L_far,0,1e-3]);
set(gcf,'position',[10,150,1400,300]);

figure();
subplot(2,2,1);imagesc(Z,x,abs(profilex).^2);title(['{\it{I}}({\it{y{\rm{,}} x}})']);
subplot(2,2,2);imagesc(Z,x,angle(profilex));title(['{\it{Phase}}({\it{y{\rm{,}} x}})']);
subplot(2,2,3);imagesc(Z,x,abs(profiley).^2);title(['{\it{I}}({\it{y{\rm{,}} z}})']);
subplot(2,2,4);imagesc(Z,x,angle(profiley));title(['{\it{Phase}}({\it{y{\rm{,}} z}})']);
set(gcf,'position',[10,50,800,500]);
%}
%效率
%{
px_target = 0;py_target = 0;
target = sqrt((Fx-px_target/Tx).^2+(Fy-py_target/Ty).^2)<(0.5/Tx);
E_in = sum(sum(abs(A1).^2))+sum(sum(abs(A2).^2));
E_out = sum(sum(abs(A3).^2));
E_far = sum(sum(abs(A3_far).^2));
E_target = sum(sum(abs(A3_far.*target).^2));
e_total = E_out/E_in;
e_target = E_target/E_in;

disp(['输入能量：' num2str(E_in)]);
disp(['输出能量(近场/远场)：' num2str(E_out) '/' num2str(E_far) '，总效率：' num2str(e_total)]);
disp(['远场目标能量：' num2str(E_target) '，目标效率：' num2str(e_target)]);
%}