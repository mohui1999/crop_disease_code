function kkk = tiqubeijing
clear 
clc
I_rgb=imread('C:\Users\Administrator\Desktop\target172.png');
figure(1);subplot(341),imshow(I_rgb);title('ԭʼͼ��');
%--------------------------------------------------------------------------
%ȥ��
filter=ones(5,5);%�����
filter=filter/sum(filter(:));%��ֵ�˲��˺���
denoised_r=conv2(I_rgb(:,:,1),filter,'same');%same��ʾ�����С������ͬ��R�ŵ��˲�
denoised_g=conv2(I_rgb(:,:,2),filter,'same');
denoised_b=conv2(I_rgb(:,:,3),filter,'same');
denoised_rgb=cat(3, denoised_r, denoised_g, denoised_b);%3ά�ϲ�����
D_rgb=uint8(denoised_rgb);%�任�������͵�0~255
subplot(342),imshow(D_rgb);title('ȥ���ͼ��');%ȥ���Ľ��
%--------------------------------------------------------------------------
%����ɫͼ���RGBת����lab��ɫ�ռ�, ��Ϊlab�ռ��໥������ϵ�ԱȽ�С ���ڷָ�
C =makecform('srgb2lab'); %����ת����ʽ
I_lab= applycform(D_rgb, C);
%--------------------------------------------------------------------------
%����K-means���ཫͼ��ָ��2������
ab =double(I_lab(:,:,2:3)); %ȡ��lab�ռ��a������b����
nrows= size(ab,1);
ncols= size(ab,2);
ab =reshape(ab,nrows*ncols,2);%�ı����ά��
nColors= 2; %�ָ���������Ϊ2
[cluster_idx,cluster_center] =kmeans(ab,nColors,'distance','sqEuclidean','Replicates',2); %�ظ�����2��
%Distance�������ȡ�sqEuclidean��ŷʽ���롣Replicates��������
pixel_labels= reshape(cluster_idx,nrows,ncols);
%--------------------------------------------------------------------------
%��ʾ�ָ��ĸ�������
segmented_images= cell(1,3);%������1��3�е�cell���͵ľ���
rgb_label= repmat(pixel_labels,[1 1 3]);%�þ���pixel_labels����[1 1 3]
for k= 1:nColors
color = I_rgb;%��ԭ��RGB�ռ�
color(rgb_label ~= k) = 0;
segmented_images{k} = color;
end
subplot(343),imshow(segmented_images{1}),title('��ȡ����');
subplot(344),imshow(segmented_images{2}),title('��ȡҶƬ');
segmented_images{2}(segmented_images{2}~=0)=255;
I0=im2bw(rgb2gray(segmented_images{2}));
subplot(345),imshow(I0),title('��ֵͼ')
%--------------------------------------------------------------------------
%��������ͨ����
L = bwlabel(I0);%�����ͨ,��������������ľֲ�����
stats = regionprops(L);
Ar = cat(1, stats.Area);
ind = find(Ar ==max(Ar));
    I1=zeros(size(I0));
    I1(L == ind) = 1;
    I0(L == ind) = 0;
subplot(346),imshow(I1,[]),title('��ͨ�����������')
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%���׶�����
I1=imfill(I1,'holes');
subplot(3,4,7), imshow(I1);title('���׶�����');
%ȥҶ��
SE = strel('rectangle',[6 5]);%���ɾ��νṹԪ��
BW2 = imerode(I1,SE);%��ͼ����и�ʴ
subplot(348),imshow(BW2); title('��ʴ���ͼ��');
L = bwlabel(BW2);%�����ͨ
stats = regionprops(L);
Ar = cat(1, stats.Area);
ind = find(Ar ==max(Ar));
    I1=zeros(size(I0));
    I1(L == ind) = 1;
    I0(L == ind) = 0;
subplot(349),imshow(I1,[]),title('��ͨ�����������')
BW2 = imdilate(I1,SE);%��ͼ���������
subplot(3,4,10), imshow(BW2);title('�ȸ�ʴ�����͵�ͼ��');

%--------------------------------------------------------------------------
%����׷��
[i,j]=size(BW2);
BW4=zeros(i,j);
B=bwboundaries(BW2);%���ر߽�ͱ�ǩ����
for k=1:length(B)
    boundary= B{k};
end
[a,b]=size(boundary);%a�Ǳ߽��ܳ�
for k=1:a
    BW4(boundary(k,1),boundary(k,2))=1;
end
subplot(3,4,11),imshow(BW4);title('�߽�׷��');
subplot(3,4,12),imshow(BW4);title('�����Ŵ�');
L1= bwlabel(BW2);%�����ͨ
start1 = regionprops(L1);
kkk=BW4;
%--------------------------------------------------------------------------
%�����С��Χ��
figure(2)
imshow(BW4);title('�ֲ�����');
hold on
[rectx,recty,area,perimeter] = minboundrect(boundary(:,1),boundary(:,2),'a'); % 'a'�ǰ���������С���Σ�������߳���'p'��
c1=sqrt((rectx(1)-rectx(2))*(rectx(1)-rectx(2))+(recty(1)-recty(2))*(recty(1)-recty(2)));%��С��Χ�г��Ȼ��߿��
c2=sqrt((rectx(2)-rectx(3))*(rectx(2)-rectx(3))+(recty(2)-recty(3))*(recty(2)-recty(3)));%��С��Χ�г��Ȼ��߿��
plot(recty,rectx,'-r');
%--------------------------------------------------------------------------
%���͹��
x=boundary(:,1);
y=boundary(:,2);
k = convhull(x,y);
plot(y(k),x(k), '-b');
hold on
x1=y(k);%��һ�к����긳ֵ 
y1=x(k);%�ڶ��������긳ֵ 
n=length(x1);%��ĸ��� 
for i=1:(n-1)
    %������߳�
    p(1,i)=sqrt((x1(i)-x1(i+1))*(x1(i)-x1(i+1))+(y1(i)-y1(i+1))*(y1(i)-y1(i+1)));
end
totalare1=sum(p(1,:));%������ͼ����ܳ�
N = length(x1);  
interv_x = zeros( 1, N - 1 ); 
mid_y = zeros( 1, N - 1); 
for i = 2 : length(x1) 
 mid_y(i-1) = ( y1(i) + y1(i-1) ) / 2; 
 interv_x(i - 1) = x1(i) - x1(i-1);  
end 
 totalare= interv_x * mid_y';%͹�����
%--------------------------------------------------------------------------
%�������
L = bwlabel(BW4);%�����ͨ
stars = regionprops(L);
e=cat(1,stars.Centroid);
plot(e(:,1),e(:,2),'w*');
for q=1:a
    t(q,1)=sqrt((boundary(q,2)-e(1,1))*(boundary(q,2)-e(1,1))+(boundary(q,1)-e(1,2))*(boundary(q,1)-e(1,2)));%���ĵ��߽�ľ���
end
p1=min(t);%���ĵ��߽���С����
p2=max(t);%���ĵ��߽�������
sita=0:pi/20:2*pi; 
%plot(r*cos(sita),r*sin(sita)); %���ĵ���ԭ�㣬�뾶Ϊr��Բ 
plot(e(1,1)+p1*cos(sita),e(1,2)+p1*sin(sita),'c');%���ĵ��ڣ�x0,y0���뾶Ϊp1��Բ
plot(e(1,1)+p2*cos(sita),e(1,2)+p2*sin(sita),'g');%���ĵ��ڣ�x0,y0���뾶Ϊp2��Բ
%--------------------------------------------------------------------------
f1=start1.Area;%ҶƬ���
f2=a;%ҶƬ�ܳ�
f3=max(c1,c2);%��С��Χ�г���
f4=min(c1,c2);%��С��Χ�п��
f5=totalare;%͹�����
f6=totalare1;%͹���ܳ�
f7=p1;%����Բ�뾶
f8=p2;%����Բ�뾶
%f9=stars.Majoraxislength;%�����������ͬ��׼�Ķ������ľ����Բ����
%f10=stars.Minoraxislength;%�����������ͬ��׼�Ķ������ľ����Բ����
th1=f3/f4;
th2=f1/f5;
th3=f2/f6;
th4=f7/f8;
th5=4*pi*f1/(f6*f6);
th6=f8/f7;
th7=4*pi*f1/(f2*f2);
th8=f1/(f3*f4);
%th9=f9/f10;
str1=['�ݺ��б�=',num2str(th1)];
str2=['�����͹��=',num2str(th2)];
str3=['�ܳ���͹��=',num2str(th3)];
str4=['������=',num2str(th4)];
str5=['Բ����=',num2str(th5)];
str6=['ƫ����=',num2str(th6)];
str7=['��״����=',num2str(th7)];
str8=['���ζ�=',num2str(th8)];
%str9=['�ȶ��׾���Բ�������=',num2str(th9)];
%gtext(str1)
%gtext(str2)
%gtext(str3)
%gtext(str4)
%gtext(str5)
%gtext(str6)
%gtext(str7)
%gtext(str8)
