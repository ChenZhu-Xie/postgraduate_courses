function [c,C,A0,a0,h0,w0,d] = detour_n(Io,phase,level,A,ax,az,h,w,l) 
% detour %(�ӹ��ṹ��Χ��������λ�ֲ�����λ�ּ����ṹ�ߴ硢��Ԫ�ߴ硢С�׸߶ȡ�С�׿�ȡ�Ŀ�����伶)
% ��������λ�ֲ�ת��Ϊ�ػ���λ�ṹ(���������)
Maxshift = ax/l;  %���ƫ������um��
phase = mod(phase,2*pi);
d = Maxshift/(level-1);
shift = round(phase./(2*pi)*(level-1));
[M,N] = size(shift);
%����С�ס��ػ���λ��Ԫ������ṹ����ά��
mA = A/d + 1;  %����ṹ����ά�ȣ�������Ե���ף�
max = ax/d;maz = az/d;  %�������ص�ά��
mh = round(h/d);  %���������п׵ľ���ά�ȣ��ߣ�
mw = round(w/d);  %���������п׵ľ���ά�ȣ���
mCx = N*max+1;mCz = M*maz+1;   %���ṹ�������ά�ȣ�
C = zeros(mA);
c = zeros(M,N);
x0 = round((mA-mCx)/2)-(max-1);  y0 = round((mA-mCz)/2)-(maz-1)+round((maz-mh)/2);
pos_x = x0 + cumsum(max*ones(M,N),2)+shift;
pos_y = y0 + cumsum(maz*ones(M,N),1);    
[index_x,index_y] = find(Io == 1);
for num = 1:length(index_x)
    i = index_x(num);j = index_y(num);
    if shift(i,j)+mw <= max
        C(pos_y(i,j):pos_y(i,j)+mh-1,pos_x(i,j):pos_x(i,j)+mw-1) = 1;
    else
        C(pos_y(i,j):pos_y(i,j)+mh-1,[pos_x(i,j)-shift(i,j):pos_x(i,j)+mw-max pos_x(i,j):pos_x(i,j)-shift(i,j)+max-1]) = 1;
    end
    c(i,j) = (j-1)*ax + d*shift(i,j);
end
A0 = d*(mA-1);a0 = d*(max-1);h0 = d*(mh-1);w0 = d*(mw-1);
%���CΪ�ṹ�ֲ���cΪ�ṹ����
%A0\a0\h0\w0,���ذ�����ɢ������ʵ�ߴ�
end

