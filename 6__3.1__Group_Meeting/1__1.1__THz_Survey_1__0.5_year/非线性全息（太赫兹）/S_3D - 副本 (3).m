clc;clear;
D = 0.15; %调制深度
h = 4;w = 1; %小孔高度为 3.5（即q_mn）、小孔宽度为 1.5（即p_mn）
q = 9; %y轴显示时拉长倍数
%传播方向为y方向，晶体光轴为z轴,倍频
%传播方向为(cos(theta_x),cos(theta_y),cos(theta_z))
theta_x = 90;
disp(['设置 晶体内 k_THz 与 x 轴夹角：' 'θx = ' num2str(theta_x) ' °'])
c = 2.99792*10^8;

%Tx = 100; Tz = 4; Ty = 50;   %实空间像素尺寸，即每一个小格子的尺寸、三维周期每个维度的周期
Ty = 30; Tz = 30; %Ty 31.5572~200 对应 1.9THz~0.3THz ; 16.9990669701 THz 对应 θy =0.00010745 °出射...
nx = 1; ny = -1; nz = 0; %倒格矢级数
disp(['设置 倒格矢级数：' 'nx = ' num2str(nx) '; ny = ' num2str(ny) '; nz = ' num2str(nz)])
%Gx = nx*2*pi/Tx; Gy = ny*2*pi/Ty; Gz = nz*2*pi/Tz;  %采样引入倒格矢
Gy = ny*2*pi/Ty; Gz = nz*2*pi/Tz;
disp(['设置 结构 y, z 向周期：' 'Ty = ' num2str(Ty) ' μm' ', Tz = ' num2str(Tz) ' μm']);

%计算匹配波长-细节倒格矢曲线
set_lam_inc = 1.5;
disp(['设置 脉冲光 中心波长：' 'Ω0 = ' num2str(set_lam_inc) ' μm']);
v_THz_min = 0.3; v_THz_max = 6;
set_v_THz = v_THz_min:0.001:v_THz_max; %THz
disp(['设置 匹配 THz 波长范围：' 'set_v_THz = ' num2str(v_THz_min) ' ~ ' num2str(v_THz_max) ' THz']);
set_lam_THz = c./(set_v_THz*10^12)*10^6; % 以0.01为增量，从0.5增加到1.5，得到一个维数组，单位可能是微米
%set_lam2 = set_lam1/2; % 上一个除以2，即倍频波的波长，会短一半
set_k_THz_LiNbO3 = n_THz(set_v_THz)*2*pi./set_lam_THz; % 给定温度T 和 给定波长下的 基波波矢大小，利用了C_n.m算晶体内相应波长和温度的折射率，其中C_n就是折射率，分子分母同时除以折射率，分母就是晶体内的波长
%set_k2 = C_n(set_lam2)*2*pi./set_lam2; % 倍频波在晶体中的波长大小，以及在晶体中相应的波矢大小，仍然是个一维数组
set_k_THz_LiNbO3_x = set_k_THz_LiNbO3.*cosd(theta_x);
set_gy = - sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-Gz^2)-Gy; % y向失配量；倍频波波矢k_3（这里是k_2）曲面被目标级次的倒格矢匹配完成后，取k_3在y轴方向的分量大小，减去两倍的基波波矢，再减去相应级次的G_y，获得该方向的差距，即倒格矢补偿后，仍还有的、剩下的y方向的波矢失配量！
% figure();plot(set_gy,set_lam1);
%disp(['计算 Tz 理论最小值：' 'Tz_min = ' num2str(nz*2*pi/max(sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2))) ' μm']);
%由于 k_THz_z_LiNbO3 不应该大于 k_THz_LiNbO3 ，所以 用于补偿它 的 Gz 不应该大于 k_THz_LiNbO3 ，所以 Gz 有个最大值（对于每个固定的 k_THz_LiNbO3，对于越大的 k_THz_LiNbO3，Gz 可取的上限越大, 上Tz越小），所以对于指定 nz，Tz 有个最小值；即使 Gz 没有达到 k_THz_z_LiNbO3 ,仍可以有不确定原理来补偿。

mz = 16; my = 16;  %实空间像素个数 多少个T_x   （-8~7一共有16个数，但只有15个长度）
y = Ty*(-my/2:my/2-1);  %实空间坐标y
z = Tz*(-mz/2:mz/2-1);  %实空间坐标z
ky = 2*pi/(Ty*(my))*(-my/2:my/2-1);   %倒空间坐标ky
kz = 2*pi/(Tz*(mz))*(-mz/2:mz/2-1);   %倒空间坐标kz

sety = 9; %设置y向匹配倒格矢位置
disp(['设置 y 向细节倒格矢：' num2str(ky(sety))]); % ky(6)：y方向上的第六个以调制区域长度为周期的倒格矢，转换为字符串，并输出打印
%disp(['计算 Ty 理论最小值：' 'Ty_min = ' num2str(ny*2*pi/min(-sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-Gz^2)-ky(sety))) ' μm']);
%-sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-Gz^2)-ky(sety) % Gz不为零时，对于扫描的频率一维数组，有一部分减去Gz的平方是负值，开根号就成了虚数，再减去ky(sety)就成了复数，min对复数数组求最小值，求的是模的最小值，而不是我想要的最负的。现在要的是 Gy 的绝对值的最大值，要最负.
%所以比 Gz^2 小的 set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2 的元素肯定不考虑，在开根号为实数的里面找最负的，或者绝对值最大的。但一旦有一个开根号是复数，则这个数组开根号全都是复数了，所以要从开根号为正的 set_k_THz_LiNbO3 元素处，开始开根号。也就是，固定 Gz，set_k_THz_LiNbO3 有个最小值，而之前是 固定 set_k_THz_LiNbO3，Gz 有个最大值。
%既然要找最负的，直接代入 v_THz_max 对应的序数 对应的 set_k_THz_LiNbO3 不就完了，反正是单调递增的，之前求 Gz 的最大值，也可以这么做；那也可以像之前那样。
%disp(['计算 Ty 理论最小值：' 'Ty_min = ' num2str(ny*2*pi/(-sqrt(max(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2)-Gz^2)-ky(sety))) ' μm']);
disp(['计算 Ty, Tz 理论最小值：' 'Ty_min = ' num2str(ny*2*pi/(-sqrt(max(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2)-Gz^2)-ky(sety))) ' μm' ', Tz_min = ' num2str(nz*2*pi/max(sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2))) ' μm']);
index1 = find(abs(set_gy-ky(sety))==min(abs(set_gy-ky(sety)))); %找到set_gy+ky(set1)即y方向的波矢失配量最接近调制区域的第六个格波波矢长度时，所对应的set_gy所对应的波长的序号（即set_gy的序号的序号），其中set_gy是个一位数组。

lam_THz_match = set_lam_THz(index1);
k_THz_match = 2*pi/lam_THz_match;
v_THz_match=c/(lam_THz_match*10^(-6))*10^(-12);% 15年 和 99年 的那两篇，色散的计算 均以频率 v 为自变量 且以 THz 为单位；05年那篇，以波数 为自变量，以 cm-1 为单位。
k_THz_match_LiNbO3 = n_THz(v_THz_match)*k_THz_match;
if abs(Gy)>k_THz_match_LiNbO3
    lam_THz_match = set_lam_THz(index1+1);
    k_THz_match = 2*pi/lam_THz_match;
    v_THz_match=c/(lam_THz_match*10^(-6))*10^(-12);% 15年 和 99年 的那两篇，色散的计算 均以频率 v 为自变量 且以 THz 为单位；05年那篇，以波数 为自变量，以 cm-1 为单位。
    k_THz_match_LiNbO3 = n_THz(v_THz_match)*k_THz_match;
end
k_THz_match_LiNbO3_x = k_THz_match_LiNbO3*cosd(theta_x);
%disp(['匹配 THz 波长：' 'λ_THz = ' num2str(lam_THz_match) ' μm']); %找到了匹配的波长所对应的序号后，将匹配的波长set_lam1(index1)展示出来。
%disp(['匹配 THz 频率：' 'ν_THz = ' num2str(v_THz_match) ' THz']); %找到了匹配的波长所对应的序号后，将匹配的波长set_lam1(index1)展示出来。
disp(['匹配 THz 波长、频率：' 'λ_THz = ' num2str(lam_THz_match) ' μm' ', ν_THz = ' num2str(v_THz_match) ' THz']);
%disp(['计算 THz 折射率：' 'n_THz = ' num2str(n_THz(v_THz_match))]);

%disp(['计算 脉冲光 群折射率：' 'n_g = ' num2str(n_g(set_lam_inc))]);
disp(['计算 THz 折射率、脉冲光 群折射率：' 'n_THz = ' num2str(n_THz(v_THz_match)) ', n_g = ' num2str(n_g(set_lam_inc))]);
Gx = k_THz_match * n_g(set_lam_inc) - k_THz_match_LiNbO3_x;
Tx = nx*2*pi/Gx;
%disp(['匹配 结构 x 向周期，设置 结构 y, z 向周期：' 'Tx = ' num2str(Tx) ', Ty = ' num2str(Ty) ', Tz = ' num2str(Tz)]);
disp(['匹配 结构 x 向周期：' 'Tx = ' num2str(Tx) ' μm' ]);
disp(['计算 结构 x, y 向周期比 与 折射率比：' 'Tx/Ty = ' num2str(Tx/Ty) ', n_THz/n_g = ' num2str(n_THz(v_THz_match)/n_g(set_lam_inc))]);

theta_y=acosd(-Gy/k_THz_match_LiNbO3);
theta_z=acosd(-Gz/k_THz_match_LiNbO3);
%disp(['设置并计算 晶体内 k_THz 与 x,y,z 轴夹角：' 'θx =' num2str(theta_x) ',θy =' num2str(theta_y) ',θz =' num2str(theta_z)]);
disp(['计算 晶体内 k_THz 与 y,z 轴夹角：' 'θy =' num2str(theta_y) ' °' ',θz =' num2str(theta_z) ' °']);




% set_lam_inc = 1.3; % 以0.01为增量，从0.5增加到1.5，得到一个维数组，单位可能是微米
% set_v_inc = c./(set_lam_inc*10^(-6))*10^(-12);  % THz
% %set_lam2 = set_lam1/2; % 上一个除以2，即倍频波的波长，会短一半
% %set_k_inc = n_inc(set_lam_inc)*2*pi./set_lam_inc;
% set_k_g = n_g(set_lam_inc)*2*pi./lam_THz_match;% 注意这里虽然折射率用的是入射光波长区间的群折射率，但是分母波长采用的是太赫兹波长，分子分母不对应，所以本不该称为 k_g，k_g中的波长应该与其折射率所处区间对应，要么全为太赫兹区间，要么全为光学区。
% set_gx = k_THz_match*cos(theta_x)-set_k_g+Gx;
% 
% setx = 9; %设置y向匹配倒格矢位置
% disp(['设置x向细节倒格矢：' num2str(kx(setx))]); % ky(6)：y方向上的第六个以调制区域长度为周期的倒格矢，转换为字符串，并输出打印
% index2 = find(abs(set_gx-kx(setx))==min(abs(set_gx-kx(setx)))); %找到set_gy-ky(set1)即y方向的波矢失配量最接近调制区域的第六个格波波矢长度时，所对应的set_gy所对应的波长的序号（即set_gy的序号的序号），其中set_gy是个一位数组。
% disp(['匹配inc波长：' num2str(set_lam_inc(index2))]); %找到了匹配的波长所对应的序号后，将匹配的波长set_lam1(index1)展示出来。
% disp(['匹配inc频率：' num2str(c/(set_v_inc(index2)*10^(-6))*10^(-12))]);
% 
% ng=n_g(set_lam_inc);
% n=n_inc(set_lam_inc);

%结构相位分布优化
mx = 16;
x = Tx*(-mx/2:mx/2-1);  %实空间坐标x 序号为-8~7，x是一个一维数组，每一个x的具体值，对应某一个最小周期结构的x边界，因含Tx而有单位

[X,Y,Z] = meshgrid(x,y,z); %用三个一维数组，生成三维网格采样点，即一个三维数组[X,Y,Z]
r = sqrt(X.^2+Y.^2+Z.^2);

kx = 2*pi/(Tx*(mx))*(-mx/2:mx/2-1);   %倒空间坐标kx 用B-K边界条件，认为正空间中15个Tx长度为一个周期，延拓，所得的倒格矢分布，取值也是-8~7，注意与Gx不同，Gx的周期是Tx，而这里的周期是15*Tx，有点像格波的波矢，比较小。

[KX,KY,KZ] = meshgrid(kx,ky,kz);
KR = sqrt(KX.^2+ KY.^2 + KZ.^2);

% w/Tx*nx+w/(Tx*mx)*lx=1/2
% lx = (1/2 - w/Tx*nx)/(w/(Tx*mx)) = (Tx*mx)/(2*w) - mx*nx = 0 或 -1 ,为了笑脸正中
% 光强最大，则 w = (Tx*mx)/(mx*nx)/2 = Tx/nx/2 或 nx = 0 对应 w = Tx （实则无周期）
% 对应 w(nx = 1) = Tx/2、 w(nx = 2) = Tx/4、 w(nx = 3) = Tx/6
% setx = lx - (-mx/2) + 1

% (Ty/2)/Ty*ny+(Ty/2)/(Ty*my)*ly=1/2
% ly = (1/2 - (Ty/2)/Ty*ny)/((Ty/2)/(Ty*my)) = (1 - ny)*my = 0    ,because (ny = 1)
% sety = ly - (-my/2) + 1 = 9

% h/Tz*nz+h/(Tz*mz)*lz=1/2
% lz = (1/2 - h/Tz*nz)/(h/(Tz*mz)) = (Tz*mz)/(2*h) - mz*nz = 0 或 -1 ,为了笑脸正中
% 光强最大，则 h = (Tz*mz)/(mz*nz)/2 = Tz/nz/2 或 nz = 0 对应 h = Tz （实则无周期）
% 对应 h(nz = 0) = Tz
% setz = lz - (-mz/2) + 1


% %基波沿y轴入射,计算波矢
% lam1 = set_lam1(index1); %在波长匹配完成后，采用匹配的波长作为基波波长
% %lam2 = lam1/2; %匹配后的倍频波在晶体中的波长
% n1 = C_n(lam1); %基波在晶体中的折射率
% %n2 = C_n(lam2,T); %倍频波在晶体中的折射率
% k1 = n1*2*pi/lam1; %基波在晶体中的波矢大小
% %k2 = n2*2*pi/lam2; %倍频波在晶体中的波矢大小
% 
% %初始化目标
% SX = -Gx; %正负调整，倍频波k2在x方向分量
% SY = -(Gy + 2*k1); %倍频波k2在y方向分量
% SZ = -Gz; %倍频波k2在z方向分量
% SR = k2; %倍频波k2的大小
% [xsurf,zsurf] = meshgrid(kx,kz); %用kx,kz两个一维数组，即调制区域的倒格矢，生成一个x-o-z平面的二维网格
% ysurf2 = SR^2 - (xsurf-SX).^2 - (zsurf-SZ).^2; %k2^2-(k2_x-kx)^2-(k2_z-kz)^2，其中k2的起点与ky的起点相同   %-(k2_y-ky)^2，其中因选了第六个面，而使得set_gy≈ky(6)。
% ysurf = sqrt(ysurf2.*(ysurf2>=0))+SY;  %计算出相位匹配球面，下一步需要找出离散倒格矢中的相近位置，当ysurf2大于等于零时， ysurf = sqrt(ysurf2)+k2_y，否则等于 k2_y
% 
% aim1 = im2double(rgb2gray(imread('xiaolian3.jpg')));  %初始化目标场分布
% aim1 = flipud(sqrt(aim1));aim1 = aim1./max(max(aim1)); %从光强到振幅，再振幅归一化
% %imshow(aim1);
% aim_F = zeros(my,mx,mz);  %初始化倒格矢分布，对应坐标轴(ky,kx,kz)，居然对应周期区域的倒格波波矢分布...16,16,16
% aim_F_refined = zeros(my,mx,mz);
% [Mx,Mz] = meshgrid(1:mx,1:mz);
% 
% for ii = 1:mx
%     for jj = 1:mz
%         [~,index_ysurf] = sort(abs(ysurf(ii,jj)-ky)); %忽略sort输出的第一个参数，将接近ysurf(ii,jj)的ky升序排列地筛选出来，不一定是ky(6)，可能是ky(7)、ky(8)，筛选出来后储存在一维数组index_ysurf中，索引号有小到大分别对应筛选出来的距离球面由远及近的ky们，即第几层们
%         aim_F(index_ysurf(1),Mx(ii,jj),Mz(ii,jj)) = aim1(ii,jj); %给aim_F的自变量三维数组中，接近倍频波波矢k2球面的单元格，赋值为 目标场归一化的振幅分布
%     end
% end
% O_C = ones(my,mx,mz); %初始化振幅系数的三维分布。
% % aim_F = aim_F./max(max(max(abs(aim_F)))); %其实由于目标场已经归一化了，不需要再归一化aim_F了
% aim_F = 1*(aim_F>0.5)+0.05*(aim_F<=0.5); %这是个什么操作?...二值化？
% for yy = 1:my
%     for ii = 1:mx
%         for jj = 1:mz
%             aim_F_refined(yy,Mx(ii,jj),Mz(ii,jj)) = aim_F(yy,Mx(ii,jj),Mz(ii,jj))/D/(h*w*Ty/2/(Tx*Ty*Tz))/sinc(w/Tx*nx+w/(mx*Tx)*(-mx/2-1+ii))/sinc(Ty/2/Ty*ny+Ty/2/(my*Ty)*(-my/2-1+yy))/sinc(h/Tz*nz+h/(mz*Tz)*(-mz/2-1+jj));
%         end
%     end
% end
% % aim_F_refined = aim_F_refined./max(max(max(abs(aim_F_refined))));
% % aim_F_refined = 1*(aim_F_refined>0.5)+0.05*(aim_F_refined<=0.5);
% 
% %作图
% % figure();slice(KX,q*KY,KZ,aim_F,[],q*ky,[]);
% % shading flat;
% % axis equal;xlabel('KX');ylabel('KY');zlabel('KZ');title(['优化目标--基波波长:' num2str(lam1)]);
% % axis([min(kx),max(kx),min(q*ky),max(q*ky),min(kz),max(kz)]);
% figure();set(gcf,'position',[40,0,600,600]);
% for i = 1:my
% subplot(4,4,i);imagesc(rot90(squeeze(aim_F(i,:,:)),1));title(['{\it{I_o}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(i) ')'],'fontname','Times New Roman','Color','black','FontSize',20);axis off;caxis([0,1]);
% end
% 
% %迭代傅里叶优化
% F = aim_F_refined;
% for i = 1:1e4
% C = fftshift(ifftn(fftshift(F))); %不是该傅里叶变换么，怎么是逆变换...卧槽。。这里还真尼玛在约束频谱的振幅...！！
% C = O_C.*exp(1i*angle(C)); %其实直接exp(1i*angle(C))就行了，取相位部分——相当于实空间的取相位部分，倒空间的约束频谱的振幅
% F = 1/(mx*my*mz)*fftshift(fftn(fftshift(C)));
% F = aim_F_refined.*exp(1i*angle(F)); %约束倒空间的振幅分布为目标场的aim_F分布。 2020.11.12：aim_F 才是 C，而这里的 C、H 是相位 or 位移
% end
% H = (angle(C));  %优化后实空间相位分布
% 
% alpha = zeros(my,mx,mz);
% for ii = 1:mx
%     for jj = 1:mz
%         alpha(:,Mx(ii,jj),Mz(ii,jj)) = H(:,Mx(ii,jj),Mz(ii,jj))/(2*pi*(nx/Tx+(-mx/2-1+ii)/(mx*Tx)));
%     end
% end
% 
% 
% 
% %作图
% % figure();slice(X,40*Y,Z,H,[],40*y,[]);
% % shading flat;axis equal;
% % figure();set(gcf,'position',[40,60,900,500]);
% % for i = 1:my
% % subplot(3,5,i);imagesc(rot90(squeeze(H(i,:,:)),1));title(['H-' num2str(i)]);axis off;caxis([-pi,pi]);
% % end
% 
% e = 0;
% HH = zeros(my+e,mz,mx);
% HH(e/2+1:my+e/2,:,:) = H;
% %验证
% F = fftshift(fftn(fftshift(exp(1i*HH))));
% %F = F./max(max(max(abs(F))));
% F_refined = zeros(my,mx,mz);
% for yy = 1:my
%     for ii = 1:mx
%         for jj = 1:mz
%             F_refined(yy,Mx(ii,jj),Mz(ii,jj)) = F(yy,Mx(ii,jj),Mz(ii,jj))*D*(h*w*Ty/2/(Tx*Ty*Tz))*sinc(w/Tx*nx+w/(mx*Tx)*(-mx/2-1+ii))*sinc(Ty/2/Ty*ny+Ty/2/(my*Ty)*(-my/2-1+yy))*sinc(h/Tz*nz+h/(mz*Tz)*(-mz/2-1+jj));
%         end
%     end
% end
% F_refined = F_refined./max(max(max(abs(F_refined)))); % 注释掉它可查看绝对强度大小，即效率。
% 
% I_F = abs(F_refined).^2; 
% P_F = angle(F_refined);
% I_aim_F = abs(aim_F).^2;
% 
% %显示
% %{
% figure();
% for num = 1:my
% xslice = []; yslice = ky(num); zslice = [];
% slice(KX,q*KY,KZ,I_F,[],q*yslice,[]);title([num2str(num),num2str(squeeze(max(max(I_F(num,:,:)))/1e5))]);
% xlabel('KX');ylabel('KY');zlabel('KZ');
% shading flat;
% axis equal;axis([min(kx),max(kx),min(q*ky),max(q*ky),min(kz),max(kz)]);
% pause(0.5);
% end
% 
% 
% [Mx,My,Mz]= meshgrid(1:mx,1:(my+e),1:mz);
% figure();slice(Mx,(mx/my)*q*My,Mz,I_F,[],(mx/my)*q*(1:my+e),[]);
% shading flat;
% axis equal;xlabel('KX');ylabel('KY');zlabel('KZ');title(['优化结果--基波波长:' num2str(lam1)]);
% % axis([min(kx),max(kx),min(q*ky),max(q*ky),min(kz),max(kz)]);
% [Mx,My,Mz]= meshgrid(1:mx,1:(my+e),1:mz);
% figure();slice(Mx,(mx/my)*q*My,Mz,P_F,[],(mx/my)*q*(1:my+e),[]);
% shading flat;
% axis equal;xlabel('KX');ylabel('KY');zlabel('KZ');title(['优化结果--基波波长:' num2str(lam1)]);
% %}
% 
% 
% figure();set(gcf,'position',[40,0,600,600]);
% for i = 1:my
% subplot(4,4,i);imagesc(rot90(squeeze(I_F(i,:,:)),1));title(['{\it{I_r}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(i) ')'],'fontname','Times New Roman','Color','black','FontSize',20);axis off;caxis([0,1]);
% end
% 
% % figure();set(gcf,'position',[40,0,600,600]);
% % for i = 1:my
% % subplot(4,4,i);imagesc(rot90(squeeze(I_aim_F(i,:,:)),1));title(['{\it{I_r}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(i) ')'],'fontname','Times New Roman','Color','black','FontSize',20);axis off;caxis([0,1]);
% % end
% 
% figure();set(gcf,'position',[40,60,900,500]);
% for i = 1:my
% subplot(4,4,i);imagesc(rot90(squeeze(H(i,:,:)),1));title(['{\it{H_p}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(i) ')'],'fontname','Times New Roman','Color','black','FontSize',20);axis off;caxis([-pi,pi]);
% end
% %squeeze是删除三维H分布中每一个只有1元素/长度为1的维度如3×2×1×1×5的矩阵，只剩3×2×5了。
% 
% %save H H;
% save alpha alpha;