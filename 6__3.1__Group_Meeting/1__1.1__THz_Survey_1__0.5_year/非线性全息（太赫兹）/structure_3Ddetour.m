clc;clear;
%将三维相位矩阵按照迂回相位编码的方式转换为结构数据

%%%-------设置结构数据存储路径----------%%%
structure_path = 'structure';
mkdir(structure_path);
rmdir(structure_path,'s');
mkdir(structure_path);

% load H  %H为三维相位分布
% [mh,nh,lh] = size(H);
load alpha  %H为三维相位分布
load wth
[mh,nh,lh] = size(alpha);
I0 = ones(nh,lh);

%结构参数
L = round(B_eff + B_eff/2) ; n = 600;%Tz = 3; %结构纵向参数（包含了厚度48以外的长度）
A = round(L_eff + L_eff/2); a = Tx; %结构尺寸为 150（包含了 长宽 d_x = d_y = 64 以外的区域，这样好看些）、单元尺寸为即w = 4
% h = 4;w = 1; %小孔高度为 3.5（即q_mn）、小孔宽度为 1.5（即p_mn）
% duty_cycle = w/a; % x向占空比
l = 2;level = 30; %目标衍射级 = 2、相位分级 = 30
Maxshift = max(max(max(abs(alpha))));

%建立坐标
Z = linspace(0,L,n);

%逐面生成结构
figure();
for i = 1:n
    z = Z(i);
    in = fix(z/Ty);
    if in <= mh && in>=1
        [c,C,A0,a0,h0,w0,d] = detour(I0,rot90(squeeze(alpha(in,:,:)),1),level,A,a,h,w,l,Maxshift);%生成迂回相位结构
    else
        % C = zeros(A*l*(level-1)/a+1);
        C = zeros(round(A/Maxshift*(level-1)) + 1); % 避免 调制和非调制区域的 矩阵维度不一致
    end
    face = (mod(z,Ty)<= t ).*C;%生成GS相位编码结构
    save([structure_path '\Structure_face' num2str(i) '.mat'],'face');
    clc;disp([num2str(z) '/' num2str(L)]);
    imagesc(face);title(['{\it{H_d}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(z) ')'],'fontname','Times New Roman','Color','black','FontSize',20);pause(0.01);  %预览
end

[m,~] = size(face);
%存储结构参数
save([structure_path '\Structure_parameter.mat'],'A','L','m','n');