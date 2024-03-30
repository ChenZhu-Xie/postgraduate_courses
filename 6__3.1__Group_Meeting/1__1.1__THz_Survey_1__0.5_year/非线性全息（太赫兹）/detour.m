function [c,C,A0,a0,h0,w0,d] = detour(Io,alpha,level,A,a,h,w,l,Maxshift) 
% detour %(加工结构范围、输入相位分布、相位分级、结构尺寸、单元尺寸、小孔高度、小孔宽度、目标衍射级)
% 将任意相位分布转换为迂回相位结构(振幅不调制)
% Maxshift = a/l;  %最大偏移量（um）
% Maxshift = max(max(max(alpha)))
%phase = mod(phase,2*pi);
d = Maxshift/(level-1); 
%shift = round(phase./(2*pi)*(level-1));
shift = round(alpha./Maxshift*(level-1));
[M,~] = size(shift);
%计算小孔、迂回相位单元、整块结构矩阵维度
mA = round(A/d) + 1;
ma = round(a/d);
mh = round(h/d);
mw = round(w/d);
mC = M*ma+1;
C = zeros(mA);
c = zeros(M);
x0 = round((mA-mC)/2)-(ma-1);  y0 = round((mA-mC)/2)-(ma-1)+round((ma-mh)/2);
pos_x = x0 + cumsum(ma*ones(M),2)+shift;
pos_y = y0 + cumsum(ma*ones(M),1);    
[index_x,index_y] = find(Io == 1);
for num = 1:length(index_x)
    i = index_x(num);j = index_y(num);
    if shift(i,j)+mw < ma
        C(pos_y(i,j):pos_y(i,j)+mh-1,pos_x(i,j):pos_x(i,j)+mw-1) = 1;
    else
        C(pos_y(i,j):pos_y(i,j)+mh-1,[pos_x(i,j)-shift(i,j):pos_x(i,j)+mw-ma pos_x(i,j):pos_x(i,j)-shift(i,j)+ma-1]) = 1;
    end
    c(i,j) = (j-1)*a + d*shift(i,j);
end
A0 = d*(mA-1);a0 = d*(ma-1);h0 = d*(mh-1);w0 = d*(mw-1);
%输出C为结构分布，c为结构坐标
%A0\a0\h0\w0,返回包含离散误差的真实尺寸
end

