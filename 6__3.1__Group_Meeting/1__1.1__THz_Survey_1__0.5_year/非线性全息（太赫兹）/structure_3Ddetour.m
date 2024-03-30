clc;clear;
%����ά��λ�������ػ���λ����ķ�ʽת��Ϊ�ṹ����

%%%-------���ýṹ���ݴ洢·��----------%%%
structure_path = 'structure';
mkdir(structure_path);
rmdir(structure_path,'s');
mkdir(structure_path);

% load H  %HΪ��ά��λ�ֲ�
% [mh,nh,lh] = size(H);
load alpha  %HΪ��ά��λ�ֲ�
load wth
[mh,nh,lh] = size(alpha);
I0 = ones(nh,lh);

%�ṹ����
L = round(B_eff + B_eff/2) ; n = 600;%Tz = 3; %�ṹ��������������˺��48����ĳ��ȣ�
A = round(L_eff + L_eff/2); a = Tx; %�ṹ�ߴ�Ϊ 150�������� ���� d_x = d_y = 64 ��������������ÿ�Щ������Ԫ�ߴ�Ϊ��w = 4
% h = 4;w = 1; %С�׸߶�Ϊ 3.5����q_mn����С�׿��Ϊ 1.5����p_mn��
% duty_cycle = w/a; % x��ռ�ձ�
l = 2;level = 30; %Ŀ�����伶 = 2����λ�ּ� = 30
Maxshift = max(max(max(abs(alpha))));

%��������
Z = linspace(0,L,n);

%�������ɽṹ
figure();
for i = 1:n
    z = Z(i);
    in = fix(z/Ty);
    if in <= mh && in>=1
        [c,C,A0,a0,h0,w0,d] = detour(I0,rot90(squeeze(alpha(in,:,:)),1),level,A,a,h,w,l,Maxshift);%�����ػ���λ�ṹ
    else
        % C = zeros(A*l*(level-1)/a+1);
        C = zeros(round(A/Maxshift*(level-1)) + 1); % ���� ���ƺͷǵ�������� ����ά�Ȳ�һ��
    end
    face = (mod(z,Ty)<= t ).*C;%����GS��λ����ṹ
    save([structure_path '\Structure_face' num2str(i) '.mat'],'face');
    clc;disp([num2str(z) '/' num2str(L)]);
    imagesc(face);title(['{\it{H_d}}({\it{x{\rm{,}} z{\rm{;}} y = }}' num2str(z) ')'],'fontname','Times New Roman','Color','black','FontSize',20);pause(0.01);  %Ԥ��
end

[m,~] = size(face);
%�洢�ṹ����
save([structure_path '\Structure_parameter.mat'],'A','L','m','n');