clc;clear;
D = 0.15; %�������
h = 4;w = 1; %С�׸߶�Ϊ 3.5����q_mn����С�׿��Ϊ 1.5����p_mn��
q = 9; %y����ʾʱ��������
%��������Ϊy���򣬾������Ϊz��,��Ƶ
%��������Ϊ(cos(theta_x),cos(theta_y),cos(theta_z))
theta_x = 90;
disp(['���� ������ k_THz �� x ��нǣ�' '��x = ' num2str(theta_x) ' ��'])
c = 2.99792*10^8;

%Tx = 100; Tz = 4; Ty = 50;   %ʵ�ռ����سߴ磬��ÿһ��С���ӵĳߴ硢��ά����ÿ��ά�ȵ�����
Ty = 30; Tz = 30; %Ty 31.5572~200 ��Ӧ 1.9THz~0.3THz ; 16.9990669701 THz ��Ӧ ��y =0.00010745 �����...
nx = 1; ny = -1; nz = 0; %����ʸ����
disp(['���� ����ʸ������' 'nx = ' num2str(nx) '; ny = ' num2str(ny) '; nz = ' num2str(nz)])
%Gx = nx*2*pi/Tx; Gy = ny*2*pi/Ty; Gz = nz*2*pi/Tz;  %�������뵹��ʸ
Gy = ny*2*pi/Ty; Gz = nz*2*pi/Tz;
disp(['���� �ṹ y, z �����ڣ�' 'Ty = ' num2str(Ty) ' ��m' ', Tz = ' num2str(Tz) ' ��m']);

%����ƥ�䲨��-ϸ�ڵ���ʸ����
set_lam_inc = 1.5;
disp(['���� ����� ���Ĳ�����' '��0 = ' num2str(set_lam_inc) ' ��m']);
v_THz_min = 0.3; v_THz_max = 6;
set_v_THz = v_THz_min:0.001:v_THz_max; %THz
disp(['���� ƥ�� THz ������Χ��' 'set_v_THz = ' num2str(v_THz_min) ' ~ ' num2str(v_THz_max) ' THz']);
set_lam_THz = c./(set_v_THz*10^12)*10^6; % ��0.01Ϊ��������0.5���ӵ�1.5���õ�һ��ά���飬��λ������΢��
%set_lam2 = set_lam1/2; % ��һ������2������Ƶ���Ĳ��������һ��
set_k_THz_LiNbO3 = n_THz(set_v_THz)*2*pi./set_lam_THz; % �����¶�T �� ���������µ� ������ʸ��С��������C_n.m�㾧������Ӧ�������¶ȵ������ʣ�����C_n���������ʣ����ӷ�ĸͬʱ���������ʣ���ĸ���Ǿ����ڵĲ���
%set_k2 = C_n(set_lam2)*2*pi./set_lam2; % ��Ƶ���ھ����еĲ�����С���Լ��ھ�������Ӧ�Ĳ�ʸ��С����Ȼ�Ǹ�һά����
set_k_THz_LiNbO3_x = set_k_THz_LiNbO3.*cosd(theta_x);
set_gy = - sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-Gz^2)-Gy; % y��ʧ��������Ƶ����ʸk_3��������k_2�����汻Ŀ�꼶�εĵ���ʸƥ����ɺ�ȡk_3��y�᷽��ķ�����С����ȥ�����Ļ�����ʸ���ټ�ȥ��Ӧ���ε�G_y����ø÷���Ĳ�࣬������ʸ�������Ի��еġ�ʣ�µ�y����Ĳ�ʸʧ������
% figure();plot(set_gy,set_lam1);
%disp(['���� Tz ������Сֵ��' 'Tz_min = ' num2str(nz*2*pi/max(sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2))) ' ��m']);
%���� k_THz_z_LiNbO3 ��Ӧ�ô��� k_THz_LiNbO3 ������ ���ڲ����� �� Gz ��Ӧ�ô��� k_THz_LiNbO3 ������ Gz �и����ֵ������ÿ���̶��� k_THz_LiNbO3������Խ��� k_THz_LiNbO3��Gz ��ȡ������Խ��, ��TzԽС�������Զ���ָ�� nz��Tz �и���Сֵ����ʹ Gz û�дﵽ k_THz_z_LiNbO3 ,�Կ����в�ȷ��ԭ����������

mz = 16; my = 16;  %ʵ�ռ����ظ��� ���ٸ�T_x   ��-8~7һ����16��������ֻ��15�����ȣ�
y = Ty*(-my/2:my/2-1);  %ʵ�ռ�����y
z = Tz*(-mz/2:mz/2-1);  %ʵ�ռ�����z
ky = 2*pi/(Ty*(my))*(-my/2:my/2-1);   %���ռ�����ky
kz = 2*pi/(Tz*(mz))*(-mz/2:mz/2-1);   %���ռ�����kz

sety = 9; %����y��ƥ�䵹��ʸλ��
disp(['���� y ��ϸ�ڵ���ʸ��' num2str(ky(sety))]); % ky(6)��y�����ϵĵ������Ե������򳤶�Ϊ���ڵĵ���ʸ��ת��Ϊ�ַ������������ӡ
%disp(['���� Ty ������Сֵ��' 'Ty_min = ' num2str(ny*2*pi/min(-sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-Gz^2)-ky(sety))) ' ��m']);
%-sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2-Gz^2)-ky(sety) % Gz��Ϊ��ʱ������ɨ���Ƶ��һά���飬��һ���ּ�ȥGz��ƽ���Ǹ�ֵ�������žͳ����������ټ�ȥky(sety)�ͳ��˸�����min�Ը�����������Сֵ�������ģ����Сֵ������������Ҫ����ġ�����Ҫ���� Gy �ľ���ֵ�����ֵ��Ҫ�.
%���Ա� Gz^2 С�� set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2 ��Ԫ�ؿ϶������ǣ��ڿ�����Ϊʵ������������ģ����߾���ֵ���ġ���һ����һ���������Ǹ�������������鿪����ȫ���Ǹ����ˣ�����Ҫ�ӿ�����Ϊ���� set_k_THz_LiNbO3 Ԫ�ش�����ʼ�����š�Ҳ���ǣ��̶� Gz��set_k_THz_LiNbO3 �и���Сֵ����֮ǰ�� �̶� set_k_THz_LiNbO3��Gz �и����ֵ��
%��ȻҪ����ģ�ֱ�Ӵ��� v_THz_max ��Ӧ������ ��Ӧ�� set_k_THz_LiNbO3 �������ˣ������ǵ��������ģ�֮ǰ�� Gz �����ֵ��Ҳ������ô������Ҳ������֮ǰ������
%disp(['���� Ty ������Сֵ��' 'Ty_min = ' num2str(ny*2*pi/(-sqrt(max(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2)-Gz^2)-ky(sety))) ' ��m']);
disp(['���� Ty, Tz ������Сֵ��' 'Ty_min = ' num2str(ny*2*pi/(-sqrt(max(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2)-Gz^2)-ky(sety))) ' ��m' ', Tz_min = ' num2str(nz*2*pi/max(sqrt(set_k_THz_LiNbO3.^2-set_k_THz_LiNbO3_x.^2))) ' ��m']);
index1 = find(abs(set_gy-ky(sety))==min(abs(set_gy-ky(sety)))); %�ҵ�set_gy+ky(set1)��y����Ĳ�ʸʧ������ӽ���������ĵ������񲨲�ʸ����ʱ������Ӧ��set_gy����Ӧ�Ĳ�������ţ���set_gy����ŵ���ţ�������set_gy�Ǹ�һλ���顣

lam_THz_match = set_lam_THz(index1);
k_THz_match = 2*pi/lam_THz_match;
v_THz_match=c/(lam_THz_match*10^(-6))*10^(-12);% 15�� �� 99�� ������ƪ��ɫɢ�ļ��� ����Ƶ�� v Ϊ�Ա��� ���� THz Ϊ��λ��05����ƪ���Բ��� Ϊ�Ա������� cm-1 Ϊ��λ��
k_THz_match_LiNbO3 = n_THz(v_THz_match)*k_THz_match;
if abs(Gy)>k_THz_match_LiNbO3
    lam_THz_match = set_lam_THz(index1+1);
    k_THz_match = 2*pi/lam_THz_match;
    v_THz_match=c/(lam_THz_match*10^(-6))*10^(-12);% 15�� �� 99�� ������ƪ��ɫɢ�ļ��� ����Ƶ�� v Ϊ�Ա��� ���� THz Ϊ��λ��05����ƪ���Բ��� Ϊ�Ա������� cm-1 Ϊ��λ��
    k_THz_match_LiNbO3 = n_THz(v_THz_match)*k_THz_match;
end
k_THz_match_LiNbO3_x = k_THz_match_LiNbO3*cosd(theta_x);
%disp(['ƥ�� THz ������' '��_THz = ' num2str(lam_THz_match) ' ��m']); %�ҵ���ƥ��Ĳ�������Ӧ����ź󣬽�ƥ��Ĳ���set_lam1(index1)չʾ������
%disp(['ƥ�� THz Ƶ�ʣ�' '��_THz = ' num2str(v_THz_match) ' THz']); %�ҵ���ƥ��Ĳ�������Ӧ����ź󣬽�ƥ��Ĳ���set_lam1(index1)չʾ������
disp(['ƥ�� THz ������Ƶ�ʣ�' '��_THz = ' num2str(lam_THz_match) ' ��m' ', ��_THz = ' num2str(v_THz_match) ' THz']);
%disp(['���� THz �����ʣ�' 'n_THz = ' num2str(n_THz(v_THz_match))]);

%disp(['���� ����� Ⱥ�����ʣ�' 'n_g = ' num2str(n_g(set_lam_inc))]);
disp(['���� THz �����ʡ������ Ⱥ�����ʣ�' 'n_THz = ' num2str(n_THz(v_THz_match)) ', n_g = ' num2str(n_g(set_lam_inc))]);
Gx = k_THz_match * n_g(set_lam_inc) - k_THz_match_LiNbO3_x;
Tx = nx*2*pi/Gx;
%disp(['ƥ�� �ṹ x �����ڣ����� �ṹ y, z �����ڣ�' 'Tx = ' num2str(Tx) ', Ty = ' num2str(Ty) ', Tz = ' num2str(Tz)]);
disp(['ƥ�� �ṹ x �����ڣ�' 'Tx = ' num2str(Tx) ' ��m' ]);
disp(['���� �ṹ x, y �����ڱ� �� �����ʱȣ�' 'Tx/Ty = ' num2str(Tx/Ty) ', n_THz/n_g = ' num2str(n_THz(v_THz_match)/n_g(set_lam_inc))]);

theta_y=acosd(-Gy/k_THz_match_LiNbO3);
theta_z=acosd(-Gz/k_THz_match_LiNbO3);
%disp(['���ò����� ������ k_THz �� x,y,z ��нǣ�' '��x =' num2str(theta_x) ',��y =' num2str(theta_y) ',��z =' num2str(theta_z)]);
disp(['���� ������ k_THz �� y,z ��нǣ�' '��y =' num2str(theta_y) ' ��' ',��z =' num2str(theta_z) ' ��']);




% set_lam_inc = 1.3; % ��0.01Ϊ��������0.5���ӵ�1.5���õ�һ��ά���飬��λ������΢��
% set_v_inc = c./(set_lam_inc*10^(-6))*10^(-12);  % THz
% %set_lam2 = set_lam1/2; % ��һ������2������Ƶ���Ĳ��������һ��
% %set_k_inc = n_inc(set_lam_inc)*2*pi./set_lam_inc;
% set_k_g = n_g(set_lam_inc)*2*pi./lam_THz_match;% ע��������Ȼ�������õ�������Ⲩ�������Ⱥ�����ʣ����Ƿ�ĸ�������õ���̫���Ȳ��������ӷ�ĸ����Ӧ�����Ա����ó�Ϊ k_g��k_g�еĲ���Ӧ���������������������Ӧ��ҪôȫΪ̫�������䣬ҪôȫΪ��ѧ����
% set_gx = k_THz_match*cos(theta_x)-set_k_g+Gx;
% 
% setx = 9; %����y��ƥ�䵹��ʸλ��
% disp(['����x��ϸ�ڵ���ʸ��' num2str(kx(setx))]); % ky(6)��y�����ϵĵ������Ե������򳤶�Ϊ���ڵĵ���ʸ��ת��Ϊ�ַ������������ӡ
% index2 = find(abs(set_gx-kx(setx))==min(abs(set_gx-kx(setx)))); %�ҵ�set_gy-ky(set1)��y����Ĳ�ʸʧ������ӽ���������ĵ������񲨲�ʸ����ʱ������Ӧ��set_gy����Ӧ�Ĳ�������ţ���set_gy����ŵ���ţ�������set_gy�Ǹ�һλ���顣
% disp(['ƥ��inc������' num2str(set_lam_inc(index2))]); %�ҵ���ƥ��Ĳ�������Ӧ����ź󣬽�ƥ��Ĳ���set_lam1(index1)չʾ������
% disp(['ƥ��incƵ�ʣ�' num2str(c/(set_v_inc(index2)*10^(-6))*10^(-12))]);
% 
% ng=n_g(set_lam_inc);
% n=n_inc(set_lam_inc);

%�ṹ��λ�ֲ��Ż�
mx = 16;
x = Tx*(-mx/2:mx/2-1);  %ʵ�ռ�����x ���Ϊ-8~7��x��һ��һά���飬ÿһ��x�ľ���ֵ����Ӧĳһ����С���ڽṹ��x�߽磬��Tx���е�λ

[X,Y,Z] = meshgrid(x,y,z); %������һά���飬������ά��������㣬��һ����ά����[X,Y,Z]
r = sqrt(X.^2+Y.^2+Z.^2);

kx = 2*pi/(Tx*(mx))*(-mx/2:mx/2-1);   %���ռ�����kx ��B-K�߽���������Ϊ���ռ���15��Tx����Ϊһ�����ڣ����أ����õĵ���ʸ�ֲ���ȡֵҲ��-8~7��ע����Gx��ͬ��Gx��������Tx���������������15*Tx���е���񲨵Ĳ�ʸ���Ƚ�С��

[KX,KY,KZ] = meshgrid(kx,ky,kz);
KR = sqrt(KX.^2+ KY.^2 + KZ.^2);

% w/Tx*nx+w/(Tx*mx)*lx=1/2
% lx = (1/2 - w/Tx*nx)/(w/(Tx*mx)) = (Tx*mx)/(2*w) - mx*nx = 0 �� -1 ,Ϊ��Ц������
% ��ǿ����� w = (Tx*mx)/(mx*nx)/2 = Tx/nx/2 �� nx = 0 ��Ӧ w = Tx ��ʵ�������ڣ�
% ��Ӧ w(nx = 1) = Tx/2�� w(nx = 2) = Tx/4�� w(nx = 3) = Tx/6
% setx = lx - (-mx/2) + 1

% (Ty/2)/Ty*ny+(Ty/2)/(Ty*my)*ly=1/2
% ly = (1/2 - (Ty/2)/Ty*ny)/((Ty/2)/(Ty*my)) = (1 - ny)*my = 0    ,because (ny = 1)
% sety = ly - (-my/2) + 1 = 9

% h/Tz*nz+h/(Tz*mz)*lz=1/2
% lz = (1/2 - h/Tz*nz)/(h/(Tz*mz)) = (Tz*mz)/(2*h) - mz*nz = 0 �� -1 ,Ϊ��Ц������
% ��ǿ����� h = (Tz*mz)/(mz*nz)/2 = Tz/nz/2 �� nz = 0 ��Ӧ h = Tz ��ʵ�������ڣ�
% ��Ӧ h(nz = 0) = Tz
% setz = lz - (-mz/2) + 1


% %������y������,���㲨ʸ
% lam1 = set_lam1(index1); %�ڲ���ƥ����ɺ󣬲���ƥ��Ĳ�����Ϊ��������
% %lam2 = lam1/2; %ƥ���ı�Ƶ���ھ����еĲ���
% n1 = C_n(lam1); %�����ھ����е�������
% %n2 = C_n(lam2,T); %��Ƶ���ھ����е�������
% k1 = n1*2*pi/lam1; %�����ھ����еĲ�ʸ��С
% %k2 = n2*2*pi/lam2; %��Ƶ���ھ����еĲ�ʸ��С
% 
% %��ʼ��Ŀ��
% SX = -Gx; %������������Ƶ��k2��x�������
% SY = -(Gy + 2*k1); %��Ƶ��k2��y�������
% SZ = -Gz; %��Ƶ��k2��z�������
% SR = k2; %��Ƶ��k2�Ĵ�С
% [xsurf,zsurf] = meshgrid(kx,kz); %��kx,kz����һά���飬����������ĵ���ʸ������һ��x-o-zƽ��Ķ�ά����
% ysurf2 = SR^2 - (xsurf-SX).^2 - (zsurf-SZ).^2; %k2^2-(k2_x-kx)^2-(k2_z-kz)^2������k2�������ky�������ͬ   %-(k2_y-ky)^2��������ѡ�˵������棬��ʹ��set_gy��ky(6)��
% ysurf = sqrt(ysurf2.*(ysurf2>=0))+SY;  %�������λƥ�����棬��һ����Ҫ�ҳ���ɢ����ʸ�е����λ�ã���ysurf2���ڵ�����ʱ�� ysurf = sqrt(ysurf2)+k2_y��������� k2_y
% 
% aim1 = im2double(rgb2gray(imread('xiaolian3.jpg')));  %��ʼ��Ŀ�곡�ֲ�
% aim1 = flipud(sqrt(aim1));aim1 = aim1./max(max(aim1)); %�ӹ�ǿ��������������һ��
% %imshow(aim1);
% aim_F = zeros(my,mx,mz);  %��ʼ������ʸ�ֲ�����Ӧ������(ky,kx,kz)����Ȼ��Ӧ��������ĵ��񲨲�ʸ�ֲ�...16,16,16
% aim_F_refined = zeros(my,mx,mz);
% [Mx,Mz] = meshgrid(1:mx,1:mz);
% 
% for ii = 1:mx
%     for jj = 1:mz
%         [~,index_ysurf] = sort(abs(ysurf(ii,jj)-ky)); %����sort����ĵ�һ�����������ӽ�ysurf(ii,jj)��ky�������е�ɸѡ��������һ����ky(6)��������ky(7)��ky(8)��ɸѡ�����󴢴���һά����index_ysurf�У���������С����ֱ��Ӧɸѡ�����ľ���������Զ������ky�ǣ����ڼ�����
%         aim_F(index_ysurf(1),Mx(ii,jj),Mz(ii,jj)) = aim1(ii,jj); %��aim_F���Ա�����ά�����У��ӽ���Ƶ����ʸk2����ĵ�Ԫ�񣬸�ֵΪ Ŀ�곡��һ��������ֲ�
%     end
% end
% O_C = ones(my,mx,mz); %��ʼ�����ϵ������ά�ֲ���
% % aim_F = aim_F./max(max(max(abs(aim_F)))); %��ʵ����Ŀ�곡�Ѿ���һ���ˣ�����Ҫ�ٹ�һ��aim_F��
% aim_F = 1*(aim_F>0.5)+0.05*(aim_F<=0.5); %���Ǹ�ʲô����?...��ֵ����
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
% %��ͼ
% % figure();slice(KX,q*KY,KZ,aim_F,[],q*ky,[]);
% % shading flat;
% % axis equal;xlabel('KX');ylabel('KY');zlabel('KZ');title(['�Ż�Ŀ��--��������:' num2str(lam1)]);
% % axis([min(kx),max(kx),min(q*ky),max(q*ky),min(kz),max(kz)]);
% figure();set(gcf,'position',[40,0,600,600]);
% for i = 1:my
% subplot(4,4,i);imagesc(rot90(squeeze(aim_F(i,:,:)),1));title(['{\it{I_o}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(i) ')'],'fontname','Times New Roman','Color','black','FontSize',20);axis off;caxis([0,1]);
% end
% 
% %��������Ҷ�Ż�
% F = aim_F_refined;
% for i = 1:1e4
% C = fftshift(ifftn(fftshift(F))); %���Ǹø���Ҷ�任ô����ô����任...�Բۡ������ﻹ��������Լ��Ƶ�׵����...����
% C = O_C.*exp(1i*angle(C)); %��ʵֱ��exp(1i*angle(C))�����ˣ�ȡ��λ���֡����൱��ʵ�ռ��ȡ��λ���֣����ռ��Լ��Ƶ�׵����
% F = 1/(mx*my*mz)*fftshift(fftn(fftshift(C)));
% F = aim_F_refined.*exp(1i*angle(F)); %Լ�����ռ������ֲ�ΪĿ�곡��aim_F�ֲ��� 2020.11.12��aim_F ���� C��������� C��H ����λ or λ��
% end
% H = (angle(C));  %�Ż���ʵ�ռ���λ�ֲ�
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
% %��ͼ
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
% %��֤
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
% F_refined = F_refined./max(max(max(abs(F_refined)))); % ע�͵����ɲ鿴����ǿ�ȴ�С����Ч�ʡ�
% 
% I_F = abs(F_refined).^2; 
% P_F = angle(F_refined);
% I_aim_F = abs(aim_F).^2;
% 
% %��ʾ
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
% axis equal;xlabel('KX');ylabel('KY');zlabel('KZ');title(['�Ż����--��������:' num2str(lam1)]);
% % axis([min(kx),max(kx),min(q*ky),max(q*ky),min(kz),max(kz)]);
% [Mx,My,Mz]= meshgrid(1:mx,1:(my+e),1:mz);
% figure();slice(Mx,(mx/my)*q*My,Mz,P_F,[],(mx/my)*q*(1:my+e),[]);
% shading flat;
% axis equal;xlabel('KX');ylabel('KY');zlabel('KZ');title(['�Ż����--��������:' num2str(lam1)]);
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
% %squeeze��ɾ����άH�ֲ���ÿһ��ֻ��1Ԫ��/����Ϊ1��ά����3��2��1��1��5�ľ���ֻʣ3��2��5�ˡ�
% 
% %save H H;
% save alpha alpha;