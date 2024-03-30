function [c,C,A0,a0,h0,w0,d] = detour_n(Io,phase,level,A,ax,az,h,w,l) 
% detour %(加工结构范围、输入相位分布、相位分级、结构尺寸、单元尺寸、小孔高度、小孔宽度、目标衍射级)
% 将任意相位分布转换为迂回相位结构(振幅不调制)
Maxshift = ax/l;  %最大偏移量（um）
phase = mod(phase,2*pi);
d = Maxshift/(level-1);
shift = round(phase./(2*pi)*(level-1));
[M,N] = size(shift);
%计算小孔、迂回相位单元、整块结构矩阵维度
mA = A/d + 1;  %整块结构矩阵维度（包括边缘留白）
max = ax/d;maz = az/d;  %单个像素的维度
mh = round(h/d);  %单个像素中孔的矩阵维度（高）
mw = round(w/d);  %单个像素中孔的矩阵维度（宽）
mCx = N*max+1;mCz = M*maz+1;   %（结构区域矩阵维度）
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
%输出C为结构分布，c为结构坐标
%A0\a0\h0\w0,返回包含离散误差的真实尺寸
end

