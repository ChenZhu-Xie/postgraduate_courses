clc;clear;
D = 0.15; %�������

q = 9; %y����ʾʱ��������
%��������Ϊy���򣬾������Ϊz��,��Ƶ
%��������Ϊ(cos(theta_x),cos(theta_y),cos(theta_z))

c = 2.99792*10^8;

Tx = 24.7726; Ty = 11; Tz = 11; %Ty 31.5572~200 ��Ӧ 1.9THz~0.3THz ; 16.9990669701 THz ��Ӧ ��y =0.00010745 �����...
Tz = Tx;% ����С��
disp(['���� �ṹ x, y, z �����ڣ�' 'Tx = ' num2str(Tx) ' ��m' '; Ty = ' num2str(Ty) ' ��m' '; Tz = ' num2str(Tz) ' ��m'])
nx = 2; ny = 0; nz = 0; %����ʸ����
disp(['���� ����ʸ������' 'nx = ' num2str(nx) '; ny = ' num2str(ny) '; nz = ' num2str(nz)])
Gx = nx*2*pi/Tx; Gy = ny*2*pi/Ty; Gz = nz*2*pi/Tz;  %�������뵹��ʸ

mx = 8; mz = 8; my = 8;  %ʵ�ռ����ظ��� ���ٸ�T_x   ��-8~7һ����16��������ֻ��15�����ȣ�
disp(['���� x, y, z ����������' 'mx = ' num2str(mx) '; my = ' num2str(my) '; mz = ' num2str(mz)]);
x = Tx*(-floor(mx/2):floor((mx-1)/2));  %ʵ�ռ�����x ���Ϊ-8~7��x��һ��һά���飬ÿһ��x�ľ���ֵ����Ӧĳһ����С���ڽṹ��x�߽磬��Tx���е�λ
y = Ty*(-floor(my/2):floor((my-1)/2));  %ʵ�ռ�����y
z = Tz*(-floor(mz/2):floor((mz-1)/2));  %ʵ�ռ�����zgx = 2*pi/(Tx*(mx))*(-mx/2:mx/2-1);   %���ռ�����kx ��B-K�߽���������Ϊ���ռ���15��Tx����Ϊһ�����ڣ����أ����õĵ���ʸ�ֲ���ȡֵҲ��-8~7��ע����Gx��ͬ��Gx��������Tx���������������15*Tx���е���񲨵Ĳ�ʸ���Ƚ�С��
set_gx = 2*pi/(Tx*(mx))*(-floor(mx/2):floor((mx-1)/2));
set_gy = 2*pi/(Ty*(my))*(-floor(my/2):floor((my-1)/2));   %���ռ�����ky
set_gz = 2*pi/(Tz*(mz))*(-floor(mz/2):floor((mz-1)/2));   %���ռ�����kz

w = Tx/4 ; t = Ty/2 ; h = Tz ; %С�׸߶�Ϊ 3.5����q_mn����С�׿��Ϊ 1.5����p_mn��
%disp(['ƥ�� �ṹ x �����ڣ����� �ṹ y, z �����ڣ�' 'Tx = ' num2str(Tx) ', Ty = ' num2str(Ty) ', Tz = ' num2str(Tz)]);
L_eff = mx*Tx ; B_eff = my*Ty ; A_eff = mz*Tz ; %��������ߴ�

lx = -4; ly = -1; lz = 0 ;
disp(['���� x, y, z ��ϸ�ڵ���ʸ��' 'lx = ' num2str(lx) '; ly = ' num2str(ly) '; lz = ' num2str(lz)]); % ky(6)��y�����ϵĵ������Ե������򳤶�Ϊ���ڵĵ���ʸ��ת��Ϊ�ַ������������ӡ
lx_seq = lx + floor(mx/2) + 1 ; %���� x ��
ly_seq = ly + floor(my/2) + 1 ; %���� y ��ƥ�䵹��ʸλ��
lz_seq = lz + floor(mz/2) + 1 ; %���� z ��
gx = set_gx(lx_seq);
gy = set_gy(ly_seq);
gz = set_gz(lz_seq);

%����ƥ�䲨��-ϸ�ڵ���ʸ����
lam_inc = 1.5;
disp(['���� ����� ���Ĳ�����' '��0 = ' num2str(lam_inc) ' ��m']);
tau_L = 75 ;%���÷��� ���� ʱ���� ������λ����
disp(['���� ����� ʱ������' '��L = ' num2str(tau_L) ' fs']);
v_THz_min = 0.845/(2*pi*tau_L*10^(-15))*10^(-12); v_THz_max = 3.155/(2*pi*tau_L*10^(-15))*10^(-12);
disp(['���� �ɵ�г�ġ�����ƥ��� THz Ƶ�ʷ�Χ��' 'set_v_THz = ' num2str(v_THz_min) ' ~ ' num2str(v_THz_max) ' THz']);
%v_THz_min = 0.3; v_THz_max = 6;
%disp(['���� ����ƥ��� THz ������Χ��' 'set_v_THz = ' num2str(v_THz_min) ' ~ ' num2str(v_THz_max) ' THz']);
set_v_THz = v_THz_min:0.001:v_THz_max; %THz
set_lam_THz = c./(set_v_THz*10^12)*10^6; % ��0.01Ϊ��������0.5���ӵ�1.5���õ�һ��ά���飬��λ������΢��
%set_lam2 = set_lam1/2; % ��һ������2������Ƶ���Ĳ��������һ��
set_k_THz_LiNbO3 = n_THz(set_v_THz)*2*pi./set_lam_THz; % �����¶�T �� ���������µ� ������ʸ��С��������C_n.m�㾧������Ӧ�������¶ȵ������ʣ�����C_n���������ʣ����ӷ�ĸͬʱ���������ʣ���ĸ���Ǿ����ڵĲ���
%set_k2 = C_n(set_lam2)*2*pi./set_lam2; % ��Ƶ���ھ����еĲ�����С���Լ��ھ�������Ӧ�Ĳ�ʸ��С����Ȼ�Ǹ�һά����
%set_gy = - sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-Gz^2)-Gy; % y��ʧ��������Ƶ����ʸk_3��������k_2�����汻Ŀ�꼶�εĵ���ʸƥ����ɺ�ȡk_3��y�᷽��ķ�����С����ȥ�����Ļ�����ʸ���ټ�ȥ��Ӧ���ε�G_y����ø÷���Ĳ�࣬������ʸ�������Ի��еġ�ʣ�µ�y����Ĳ�ʸʧ������
% figure();plot(set_gy,set_lam1);
%disp(['���� Tz ������Сֵ��' 'Tz_min = ' num2str(nz*2*pi/max(sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2))) ' ��m']);
%���� k_THz_z_LiNbO3 ��Ӧ�ô��� k_THz_LiNbO3 ������ ���ڲ����� �� Gz ��Ӧ�ô��� k_THz_LiNbO3 ������ Gz �и����ֵ������ÿ���̶��� k_THz_LiNbO3������Խ��� k_THz_LiNbO3��Gz ��ȡ������Խ��, ��TzԽС�������Զ���ָ�� nz��Tz �и���Сֵ����ʹ Gz û�дﵽ k_THz_z_LiNbO3 ,�Կ����в�ȷ��ԭ����������
%disp(['���� Tz ������Сֵ��' 'Tz_min = ' num2str(abs(nz)*2*pi/max(sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2))) ' ��m']);
%�� Tz �� nz ������ �����С�

%disp(['���� Ty ������Сֵ��' 'Ty_min = ' num2str(ny*2*pi/min(-sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-Gz^2)-ky(sety))) ' ��m']);
%-sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-Gz^2)-ky(sety) % Gz��Ϊ��ʱ������ɨ���Ƶ��һά���飬��һ���ּ�ȥGz��ƽ���Ǹ�ֵ�������žͳ����������ټ�ȥky(sety)�ͳ��˸�����min�Ը�����������Сֵ�������ģ����Сֵ������������Ҫ����ġ�����Ҫ���� Gy �ľ���ֵ�����ֵ��Ҫ�.
%���Ա� Gz^2 С�� set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2 ��Ԫ�ؿ϶������ǣ��ڿ�����Ϊʵ������������ģ����߾���ֵ���ġ���һ����һ���������Ǹ�������������鿪����ȫ���Ǹ����ˣ�����Ҫ�ӿ�����Ϊ���� set_k_THz_LiNbO3 Ԫ�ش�����ʼ�����š�Ҳ���ǣ��̶� Gz��set_k_THz_LiNbO3 �и���Сֵ����֮ǰ�� �̶� set_k_THz_LiNbO3��Gz �и����ֵ��
%��ȻҪ����ģ�ֱ�Ӵ��� v_THz_max ��Ӧ������ ��Ӧ�� set_k_THz_LiNbO3 �������ˣ������ǵ��������ģ�֮ǰ�� Gz �����ֵ��Ҳ������ô������Ҳ������֮ǰ������
%disp(['���� Ty ������Сֵ��' 'Ty_min = ' num2str(ny*2*pi/(-sqrt(max(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2)-Gz^2)-ky(sety))) ' ��m']);

Gzplusgzmo_max = max(set_k_THz_LiNbO3);
Tz_min = abs(nz + lz/mz)*2*pi/Gzplusgzmo_max;
Ty_min = 0;
Tx_min = 0;
if abs(Gz + gz) < Gzplusgzmo_max
    Gyplusgymo_max = sqrt(Gzplusgzmo_max^2 - (Gz + gz)^2);
    Ty_min = abs(ny + ly/my)*2*pi/Gyplusgymo_max;
    if abs(Gy + gy) < Gyplusgymo_max
        if sqrt((Gy + gy)^2 + (Gz + gz)^2) < min(set_k_THz_LiNbO3)
            Gxplusgxmo_min = sqrt(min(set_k_THz_LiNbO3)^2 - (Gy + gy)^2 - (Gz + gz)^2);
            Tx_max = abs(nx + lx/mx)*2*pi/Gxplusgxmo_min;
        end
        Gxplusgxmo_max = sqrt(Gyplusgymo_max^2 - (Gy + gy)^2);
        Tx_min = abs(nx + lx/mx)*2*pi/Gxplusgxmo_max;
    end
end

if sqrt((Gy + gy)^2 + (Gz + gz)^2) < min(set_k_THz_LiNbO3)
    disp(['���� Tx, Ty, Tz ƥ�䷶Χ�����ȼ�Ϊ Tz �� Ty �� Tx����' 'Tx �� ' num2str(Tx_min) ' ~ ' num2str(Tx_max) ' ��m' ', Ty �� ' num2str(Ty_min) ' ~ ' '��' ' ��m' ', Tz �� ' num2str(Tz_min) ' ~ ' '��' ' ��m']);
else
    disp(['���� Tx, Ty, Tz ƥ�䷶Χ�����ȼ�Ϊ Tz �� Ty �� Tx����' 'Tx �� ' num2str(Tx_min) ' ~ ' '��' ' ��m' ', Ty �� ' num2str(Ty_min) ' ~ ' '��' ' ��m' ', Tz �� ' num2str(Tz_min) ' ~ ' '��' ' ��m']);
end

%�� Ty �� ny ������ �����С�
%index1 = find(abs(set_gy-ky(sety))==min(abs(set_gy-ky(sety)))); %�ҵ�set_gy+ky(set1)��y����Ĳ�ʸʧ������ӽ���������ĵ������񲨲�ʸ����ʱ������Ӧ��set_gy����Ӧ�Ĳ�������ţ���set_gy����ŵ���ţ�������set_gy�Ǹ�һλ���顣
%index1 = find(abs((set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-(Gz + gz)^2)-(Gy + gy)^2) == min(abs((set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-(Gz + gz)^2)-(Gy + gy)^2)));
%��GyҲ����ƽ�����ü����Gy�����������С�

Gg = sqrt((Gx + gx)^2 + (Gy + gy)^2 + (Gz + gz)^2);
a = sqrt((Gy + gy)^2 + (Gz + gz)^2)/(Gx + gx);
b = n_g(lam_inc)./n_THz(set_v_THz);
if a > 0
    costhetax = (a^2*b - sqrt(a^2 + 1 - a^2*b.^2))/(a^2 + 1);
else
    costhetax = (a^2*b + sqrt(a^2 + 1 - a^2*b.^2))/(a^2 + 1);
end
index1 = find(abs(set_k_THz_LiNbO3.^2.*(1 + b.^2 - 2*b.*costhetax) - Gg^2) == min(abs(set_k_THz_LiNbO3.^2.*(1 + b.^2 - 2*b.*costhetax) - Gg^2)));
%��GyҲ����ƽ�����ü����Gy�����������С�

lam_THz_match = set_lam_THz(index1);
k_THz_match = 2*pi/lam_THz_match;
v_THz_match = c/(lam_THz_match*10^(-6))*10^(-12);% 15�� �� 99�� ������ƪ��ɫɢ�ļ��� ����Ƶ�� v Ϊ�Ա��� ���� THz Ϊ��λ��05����ƪ���Բ��� Ϊ�Ա������� cm-1 Ϊ��λ��
k_THz_match_LiNbO3 = n_THz(v_THz_match)*k_THz_match;
if (Gx + gx)^2 + (Gy + gy)^2 + (Gz + gz)^2 > k_THz_match_LiNbO3^2 
    if index1 == length(set_v_THz)
        disp(['ƥ�� THz ������Ƶ�ʣ�' '��_THz = ' num2str(lam_THz_match) ' ��m' ', ��_THz = ' num2str(v_THz_match) ' THz' ' �������� ���С ������������� THz���� ����Ƶ�ʣ��� ���� Tx, Ty, Tz �Լ�Сƥ�䵹��ʸ']);
    else % ���������������ϸ�Ҫ�� G ���ṩ�ĵ���ʸ Ҫ�� ̫���Ȳ�ʸ�����ڡ�֮ǰ֮����Ҫ�� G �Ĳ��ַ����������ڣ���ʵ��Ҫ����С����İ뾶���Ը� G �����������ṩ ƥ��ռ䡣
        lam_THz_match = set_lam_THz(index1+1);
        k_THz_match = 2*pi/lam_THz_match;
        v_THz_match=c/(lam_THz_match*10^(-6))*10^(-12);% 15�� �� 99�� ������ƪ��ɫɢ�ļ��� ����Ƶ�� v Ϊ�Ա��� ���� THz Ϊ��λ��05����ƪ���Բ��� Ϊ�Ա������� cm-1 Ϊ��λ��
        k_THz_match_LiNbO3 = n_THz(v_THz_match)*k_THz_match;
        disp(['ƥ�� THz ������Ƶ�ʣ�' '��_THz = ' num2str(lam_THz_match) ' ��m' ', ��_THz = ' num2str(v_THz_match) ' THz']);
    end
else
    if index1 == 1
        disp(['ƥ�� THz ������Ƶ�ʣ�' '��_THz = ' num2str(lam_THz_match) ' ��m' ', ��_THz = ' num2str(v_THz_match) ' THz' ' �������� ������ ���������Խ��� THz���� ����Ƶ�ʣ��� ��С Tx, Ty, Tz ������ƥ�䵹��ʸ']);
    else
        disp(['ƥ�� THz ������Ƶ�ʣ�' '��_THz = ' num2str(lam_THz_match) ' ��m' ', ��_THz = ' num2str(v_THz_match) ' THz']);
    end
end
%disp(['ƥ�� THz ������' '��_THz = ' num2str(lam_THz_match) ' ��m']); %�ҵ���ƥ��Ĳ�������Ӧ����ź󣬽�ƥ��Ĳ���set_lam1(index1)չʾ������
%disp(['ƥ�� THz Ƶ�ʣ�' '��_THz = ' num2str(v_THz_match) ' THz']); %�ҵ���ƥ��Ĳ�������Ӧ����ź󣬽�ƥ��Ĳ���set_lam1(index1)չʾ������
%disp(['ƥ�� THz ������Ƶ�ʣ�' '��_THz = ' num2str(lam_THz_match) ' ��m' ', ��_THz = ' num2str(v_THz_match) ' THz']);
%disp(['���� THz �����ʣ�' 'n_THz = ' num2str(n_THz(v_THz_match))]);

%disp(['���� ����� Ⱥ�����ʣ�' 'n_g = ' num2str(n_g(set_lam_inc))]);
disp(['���� THz �����ʡ������ Ⱥ�����ʣ�' 'n_THz = ' num2str(n_THz(v_THz_match)) ', n_g = ' num2str(n_g(lam_inc))]);
disp(['���� ���׿Ʒ�ǣ�' '��_xc = ' num2str(acosd(n_g(lam_inc)/n_THz(v_THz_match))) ' ��']);
disp(['���� �ṹ x, y �����ڱȡ� y, x �򵹸�ʸ�ȡ� �����ʱȣ�' '(Gy + gy)/(Gx + gx) = ' num2str((Gy + gy)/(Gx + gx)) ', Tx/Ty = ' num2str(Tx/Ty) ', n_THz/n_g = ' num2str(n_THz(v_THz_match)/n_g(lam_inc))]);

theta_x = acosd((k_THz_match * n_g(lam_inc) - (Gx + gx))/k_THz_match_LiNbO3);
theta_y = acosd(-(Gy + gy)/k_THz_match_LiNbO3);
theta_z = acosd(-(Gz + gz)/k_THz_match_LiNbO3);
%disp(['���ò����� ������ k_THz �� x,y,z ��нǣ�' '��x =' num2str(theta_x) ',��y =' num2str(theta_y) ',��z =' num2str(theta_z)]);
disp(['���� ������ k_THz �� x, y, z ��нǣ�' '��x = ' num2str(theta_x) ' ��' ', ��y = ' num2str(theta_y) ' ��' ',��z = ' num2str(theta_z) ' ��']);

%�ṹ��λ�ֲ��Ż�
[X,Y,Z] = meshgrid(x,y,z); %������һά���飬������ά��������㣬��һ����ά����[X,Y,Z]
r = sqrt(X.^2+Y.^2+Z.^2);
[gX,gY,gZ] = meshgrid(set_gx,set_gy,set_gz);
gR = sqrt(gX.^2+ gY.^2 + gZ.^2);

% w/Tx*nx+w/(Tx*mx)*lx=1/2
% lx = (1/2 - w/Tx*nx)/(w/(Tx*mx)) = (Tx*mx)/(2*w) - mx*nx = 0 �� -1 ,Ϊ��Ц������
% ��ǿ����� w = (Tx*mx)/(mx*nx)/2 = Tx/nx/2 �� nx = 0 ��Ӧ w = Tx ��ʵ�������ڣ�
% ��Ӧ w(nx = 1) = Tx/2�� w(nx = 2) = Tx/4�� w(nx = 3) = Tx/6
% setx = lx - (-mx/2) + 1
% 
% (Ty/2)/Ty*ny+(Ty/2)/(Ty*my)*ly=1/2
% ly = (1/2 - (Ty/2)/Ty*ny)/((Ty/2)/(Ty*my)) = (1 - ny)*my = 0    ,because (ny = 1)
% sety = ly - (-my/2) + 1 = 9
% 
% h/Tz*nz+h/(Tz*mz)*lz=1/2
% lz = (1/2 - h/Tz*nz)/(h/(Tz*mz)) = (Tz*mz)/(2*h) - mz*nz = 0 �� -1 ,Ϊ��Ц������
% ��ǿ����� h = (Tz*mz)/(mz*nz)/2 = Tz/nz/2 �� nz = 0 ��Ӧ h = Tz ��ʵ�������ڣ�
% ��Ӧ h(nz = 0) = Tz
% setz = lz - (-mz/2) + 1

%�������x������,������棨y�򣩳���� THz ��ʸ����
[gx_surf,gz_surf] = meshgrid(set_gx,set_gz);
gy_surf2 = k_THz_match_LiNbO3^2 - (k_THz_match * n_g(lam_inc) - Gx - gx_surf).^2 - (Gz + gz_surf).^2;
panduan = 1*(gy_surf2>=0);
if Gy + gy > 0 
    gy_surf = sqrt(gy_surf2.*panduan) - Gy;
    % ����һ������ֵ ��Ϊ�˱�֤ �������Ǹ��Ǹ�ֵ��һ�㶼�ǷǸ��ġ�
else
    gy_surf = - sqrt(gy_surf2.*panduan) - Gy;
end
    
aim1 = im2double(rgb2gray(imread('xiaolian4.jpg')));  %��ʼ��Ŀ�곡�ֲ�
aim1 = flipud(sqrt(aim1));aim1 = aim1./max(max(aim1)); %�ӹ�ǿ��������������һ��
%imshow(aim1);
aim_F = zeros(my,mx,mz);  %��ʼ������ʸ�ֲ�����Ӧ������(ky,kx,kz)����Ȼ��Ӧ��������ĵ��񲨲�ʸ�ֲ�...16,16,16
aim_F_refined = zeros(my,mx,mz);
[Mx,Mz] = meshgrid(1:mx,1:mz);

for ii = 1:mx
    for jj = 1:mz
        [~,index_gysurf] = sort(abs(gy_surf(ii,jj)-set_gy)); %����sort����ĵ�һ�����������ӽ�ysurf(ii,jj)��ky�������е�ɸѡ��������һ����ky(6)��������ky(7)��ky(8)��ɸѡ�����󴢴���һά����index_ysurf�У���������С����ֱ��Ӧɸѡ�����ľ���������Զ������ky�ǣ����ڼ�����
        aim_F(index_gysurf(1),Mx(ii,jj),Mz(ii,jj)) = aim1(ii,jj); %��aim_F���Ա�����ά�����У��ӽ���Ƶ����ʸk2����ĵ�Ԫ�񣬸�ֵΪ Ŀ�곡��һ��������ֲ�
    end
end
O_C = ones(my,mx,mz); %��ʼ�����ϵ������ά�ֲ���
% aim_F = aim_F./max(max(max(abs(aim_F)))); %��ʵ����Ŀ�곡�Ѿ���һ���ˣ�����Ҫ�ٹ�һ��aim_F��
aim_F = 1*(aim_F>0.5)+0.05*(aim_F<=0.5); %���Ǹ�ʲô����?...��ֵ����
for yy = 1:my
    for ii = 1:mx
        for jj = 1:mz
            aim_F_refined(yy,Mx(ii,jj),Mz(ii,jj)) = aim_F(yy,Mx(ii,jj),Mz(ii,jj))/D/(h*w*Ty/2/(Tx*Ty*Tz))/sinc(w/Tx*nx+w/(mx*Tx)*(-mx/2-1+ii))/sinc(Ty/2/Ty*ny+Ty/2/(my*Ty)*(-my/2-1+yy))/sinc(h/Tz*nz+h/(mz*Tz)*(-mz/2-1+jj));
        end
    end
end
% aim_F_refined = aim_F_refined./max(max(max(abs(aim_F_refined))));
% aim_F_refined = 1*(aim_F_refined>0.5)+0.05*(aim_F_refined<=0.5);

%��ͼ
% figure();slice(KX,q*KY,KZ,aim_F,[],q*ky,[]);
% shading flat;
% axis equal;xlabel('KX');ylabel('KY');zlabel('KZ');title(['�Ż�Ŀ��--��������:' num2str(lam1)]);
% axis([min(kx),max(kx),min(q*ky),max(q*ky),min(kz),max(kz)]);
figure();set(gcf,'position',[40,0,600,600]);
for i = 1:my
subplot(4,4,i);imagesc(rot90(squeeze(aim_F(i,:,:)),1));title(['{\it{I_o}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(i) ')'],'fontname','Times New Roman','Color','black','FontSize',20);axis off;caxis([0,1]);
end

%��������Ҷ�Ż�
F = aim_F_refined;
for i = 1:1e4
C = fftshift(ifftn(fftshift(F))); %���Ǹø���Ҷ�任ô����ô����任...�Բۡ������ﻹ��������Լ��Ƶ�׵����...����
C = O_C.*exp(1i*angle(C)); %��ʵֱ��exp(1i*angle(C))�����ˣ�ȡ��λ���֡����൱��ʵ�ռ��ȡ��λ���֣����ռ��Լ��Ƶ�׵����
F = 1/(mx*my*mz)*fftshift(fftn(fftshift(C)));
F = aim_F_refined.*exp(1i*angle(F)); %Լ�����ռ������ֲ�ΪĿ�곡��aim_F�ֲ��� 2020.11.12��aim_F ���� C��������� C��H ����λ or λ��
end
H = (angle(C));  %�Ż���ʵ�ռ���λ�ֲ�

alpha = zeros(my,mx,mz);
for ii = 1:mx
    for jj = 1:mz
        for kk = 1:my
            if -mx/2-1+ii ~= 0
                alpha(kk,Mx(ii,jj),Mz(ii,jj)) = H(kk,Mx(ii,jj),Mz(ii,jj))/(2*pi*(nx/Tx+(-mx/2-1+ii)/(mx*Tx)));
            else
                alpha(kk,Mx(ii,jj),Mz(ii,jj)) = 0;
            end
        end
    end
end

Maxshift = max(max(max(abs(alpha))));
disp(['���� �����ƣ�' 'Maxshift = ' num2str(Maxshift) ' ��m']);

%��ͼ
% figure();slice(X,40*Y,Z,H,[],40*y,[]);
% shading flat;axis equal;
% figure();set(gcf,'position',[40,60,900,500]);
% for i = 1:my
% subplot(3,5,i);imagesc(rot90(squeeze(H(i,:,:)),1));title(['H-' num2str(i)]);axis off;caxis([-pi,pi]);
% end

e = 0;
HH = zeros(my+e,mz,mx);
HH(e/2+1:my+e/2,:,:) = H;
%��֤
F = fftshift(fftn(fftshift(exp(1i*HH))));
%F = F./max(max(max(abs(F))));
F_refined = zeros(my,mx,mz);
for yy = 1:my
    for ii = 1:mx
        for jj = 1:mz
            F_refined(yy,Mx(ii,jj),Mz(ii,jj)) = F(yy,Mx(ii,jj),Mz(ii,jj))*D*(h*w*Ty/2/(Tx*Ty*Tz))*sinc(w/Tx*nx+w/(mx*Tx)*(-mx/2-1+ii))*sinc(Ty/2/Ty*ny+Ty/2/(my*Ty)*(-my/2-1+yy))*sinc(h/Tz*nz+h/(mz*Tz)*(-mz/2-1+jj));
        end
    end
end
F_refined = F_refined./max(max(max(abs(F_refined)))); % ע�͵����ɲ鿴����ǿ�ȴ�С����Ч�ʡ�

I_F = abs(F_refined).^2; 
P_F = angle(F_refined);
I_aim_F = abs(aim_F).^2;

%��ʾ
%{
figure();
for num = 1:my
xslice = []; yslice = ky(num); zslice = [];
slice(KX,q*KY,KZ,I_F,[],q*yslice,[]);title([num2str(num),num2str(squeeze(max(max(I_F(num,:,:)))/1e5))]);
xlabel('KX');ylabel('KY');zlabel('KZ');
shading flat;
axis equal;axis([min(kx),max(kx),min(q*ky),max(q*ky),min(kz),max(kz)]);
pause(0.5);
end


[Mx,My,Mz]= meshgrid(1:mx,1:(my+e),1:mz);
figure();slice(Mx,(mx/my)*q*My,Mz,I_F,[],(mx/my)*q*(1:my+e),[]);
shading flat;
axis equal;xlabel('KX');ylabel('KY');zlabel('KZ');title(['�Ż����--��������:' num2str(lam1)]);
% axis([min(kx),max(kx),min(q*ky),max(q*ky),min(kz),max(kz)]);
[Mx,My,Mz]= meshgrid(1:mx,1:(my+e),1:mz);
figure();slice(Mx,(mx/my)*q*My,Mz,P_F,[],(mx/my)*q*(1:my+e),[]);
shading flat;
axis equal;xlabel('KX');ylabel('KY');zlabel('KZ');title(['�Ż����--��������:' num2str(lam1)]);
%}


figure();set(gcf,'position',[40,0,600,600]);
for i = 1:my
subplot(4,4,i);imagesc(rot90(squeeze(I_F(i,:,:)),1));title(['{\it{I_r}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(i) ')'],'fontname','Times New Roman','Color','black','FontSize',20);axis off;caxis([0,1]);
end

% figure();set(gcf,'position',[40,0,600,600]);
% for i = 1:my
% subplot(4,4,i);imagesc(rot90(squeeze(I_aim_F(i,:,:)),1));title(['{\it{I_r}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(i) ')'],'fontname','Times New Roman','Color','black','FontSize',20);axis off;caxis([0,1]);
% end

figure();set(gcf,'position',[40,60,900,500]);
for i = 1:my
subplot(4,4,i);imagesc(rot90(squeeze(H(i,:,:)),1));title(['{\it{H_p}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(i) ')'],'fontname','Times New Roman','Color','black','FontSize',20);axis off;caxis([-pi,pi]);
end
%squeeze��ɾ����άH�ֲ���ÿһ��ֻ��1Ԫ��/����Ϊ1��ά����3��2��1��1��5�ľ���ֻʣ3��2��5�ˡ�

%save H H;
save alpha alpha;
save wth w t h Tx L_eff Ty B_eff A_eff;