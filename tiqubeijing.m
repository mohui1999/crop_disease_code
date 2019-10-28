function kkk = tiqubeijing
clear 
clc
I_rgb=imread('C:\Users\Administrator\Desktop\target172.png');
figure(1);subplot(341),imshow(I_rgb);title('原始图像');
%--------------------------------------------------------------------------
%去噪
filter=ones(5,5);%卷积核
filter=filter/sum(filter(:));%均值滤波核函数
denoised_r=conv2(I_rgb(:,:,1),filter,'same');%same表示输出大小与输入同，R信道滤波
denoised_g=conv2(I_rgb(:,:,2),filter,'same');
denoised_b=conv2(I_rgb(:,:,3),filter,'same');
denoised_rgb=cat(3, denoised_r, denoised_g, denoised_b);%3维合并矩阵
D_rgb=uint8(denoised_rgb);%变换数据类型到0~255
subplot(342),imshow(D_rgb);title('去噪后图像');%去噪后的结果
%--------------------------------------------------------------------------
%将彩色图像从RGB转化到lab彩色空间, 因为lab空间相互分量联系性比较小 利于分割
C =makecform('srgb2lab'); %设置转换格式
I_lab= applycform(D_rgb, C);
%--------------------------------------------------------------------------
%进行K-means聚类将图像分割成2个区域
ab =double(I_lab(:,:,2:3)); %取出lab空间的a分量和b分量
nrows= size(ab,1);
ncols= size(ab,2);
ab =reshape(ab,nrows*ncols,2);%改变矩阵维数
nColors= 2; %分割的区域个数为2
[cluster_idx,cluster_center] =kmeans(ab,nColors,'distance','sqEuclidean','Replicates',2); %重复聚类2次
%Distance，距离测度。sqEuclidean，欧式距离。Replicates，整数。
pixel_labels= reshape(cluster_idx,nrows,ncols);
%--------------------------------------------------------------------------
%显示分割后的各个区域
segmented_images= cell(1,3);%构造了1行3列的cell类型的矩阵
rgb_label= repmat(pixel_labels,[1 1 3]);%用矩阵pixel_labels复制[1 1 3]
for k= 1:nColors
color = I_rgb;%还原到RGB空间
color(rgb_label ~= k) = 0;
segmented_images{k} = color;
end
subplot(343),imshow(segmented_images{1}),title('提取背景');
subplot(344),imshow(segmented_images{2}),title('提取叶片');
segmented_images{2}(segmented_images{2}~=0)=255;
I0=im2bw(rgb2gray(segmented_images{2}));
subplot(345),imshow(I0),title('二值图')
%--------------------------------------------------------------------------
%标记最大连通区域
L = bwlabel(I0);%标记连通,这个函数是求它的局部属性
stats = regionprops(L);
Ar = cat(1, stats.Area);
ind = find(Ar ==max(Ar));
    I1=zeros(size(I0));
    I1(L == ind) = 1;
    I0(L == ind) = 0;
subplot(346),imshow(I1,[]),title('连通面积最大的区域')
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%填充孔洞操作
I1=imfill(I1,'holes');
subplot(3,4,7), imshow(I1);title('填充孔洞操作');
%去叶柄
SE = strel('rectangle',[6 5]);%生成矩形结构元素
BW2 = imerode(I1,SE);%对图像进行腐蚀
subplot(348),imshow(BW2); title('腐蚀后的图像');
L = bwlabel(BW2);%标记连通
stats = regionprops(L);
Ar = cat(1, stats.Area);
ind = find(Ar ==max(Ar));
    I1=zeros(size(I0));
    I1(L == ind) = 1;
    I0(L == ind) = 0;
subplot(349),imshow(I1,[]),title('连通面积最大的区域')
BW2 = imdilate(I1,SE);%对图像进行膨胀
subplot(3,4,10), imshow(BW2);title('先腐蚀后膨胀的图像');

%--------------------------------------------------------------------------
%轮廓追踪
[i,j]=size(BW2);
BW4=zeros(i,j);
B=bwboundaries(BW2);%返回边界和标签矩阵
for k=1:length(B)
    boundary= B{k};
end
[a,b]=size(boundary);%a是边界周长
for k=1:a
    BW4(boundary(k,1),boundary(k,2))=1;
end
subplot(3,4,11),imshow(BW4);title('边界追踪');
subplot(3,4,12),imshow(BW4);title('轮廓放大');
L1= bwlabel(BW2);%标记连通
start1 = regionprops(L1);
kkk=BW4;
%--------------------------------------------------------------------------
%标记最小包围盒
figure(2)
imshow(BW4);title('局部属性');
hold on
[rectx,recty,area,perimeter] = minboundrect(boundary(:,1),boundary(:,2),'a'); % 'a'是按面积算的最小矩形，如果按边长用'p'。
c1=sqrt((rectx(1)-rectx(2))*(rectx(1)-rectx(2))+(recty(1)-recty(2))*(recty(1)-recty(2)));%最小包围盒长度或者宽度
c2=sqrt((rectx(2)-rectx(3))*(rectx(2)-rectx(3))+(recty(2)-recty(3))*(recty(2)-recty(3)));%最小包围盒长度或者宽度
plot(recty,rectx,'-r');
%--------------------------------------------------------------------------
%标记凸包
x=boundary(:,1);
y=boundary(:,2);
k = convhull(x,y);
plot(y(k),x(k), '-b');
hold on
x1=y(k);%第一列横坐标赋值 
y1=x(k);%第二列纵坐标赋值 
n=length(x1);%点的个数 
for i=1:(n-1)
    %计算各边长
    p(1,i)=sqrt((x1(i)-x1(i+1))*(x1(i)-x1(i+1))+(y1(i)-y1(i+1))*(y1(i)-y1(i+1)));
end
totalare1=sum(p(1,:));%不规则图像的周长
N = length(x1);  
interv_x = zeros( 1, N - 1 ); 
mid_y = zeros( 1, N - 1); 
for i = 2 : length(x1) 
 mid_y(i-1) = ( y1(i) + y1(i-1) ) / 2; 
 interv_x(i - 1) = x1(i) - x1(i-1);  
end 
 totalare= interv_x * mid_y';%凸包面积
%--------------------------------------------------------------------------
%标记质心
L = bwlabel(BW4);%标记连通
stars = regionprops(L);
e=cat(1,stars.Centroid);
plot(e(:,1),e(:,2),'w*');
for q=1:a
    t(q,1)=sqrt((boundary(q,2)-e(1,1))*(boundary(q,2)-e(1,1))+(boundary(q,1)-e(1,2))*(boundary(q,1)-e(1,2)));%质心到边界的距离
end
p1=min(t);%质心到边界最小距离
p2=max(t);%质心到边界最大距离
sita=0:pi/20:2*pi; 
%plot(r*cos(sita),r*sin(sita)); %中心点在原点，半径为r的圆 
plot(e(1,1)+p1*cos(sita),e(1,2)+p1*sin(sita),'c');%中心点在（x0,y0）半径为p1的圆
plot(e(1,1)+p2*cos(sita),e(1,2)+p2*sin(sita),'g');%中心点在（x0,y0）半径为p2的圆
%--------------------------------------------------------------------------
f1=start1.Area;%叶片面积
f2=a;%叶片周长
f3=max(c1,c2);%最小包围盒长度
f4=min(c1,c2);%最小包围盒宽度
f5=totalare;%凸包面积
f6=totalare1;%凸包周长
f7=p1;%内切圆半径
f8=p2;%外切圆半径
%f9=stars.Majoraxislength;%与区域具有相同标准的二阶中心距的椭圆长轴
%f10=stars.Minoraxislength;%与区域具有相同标准的二阶中心距的椭圆短轴
th1=f3/f4;
th2=f1/f5;
th3=f2/f6;
th4=f7/f8;
th5=4*pi*f1/(f6*f6);
th6=f8/f7;
th7=4*pi*f1/(f2*f2);
th8=f1/(f3*f4);
%th9=f9/f10;
str1=['纵横中比=',num2str(th1)];
str2=['面积凹凸比=',num2str(th2)];
str3=['周长凹凸比=',num2str(th3)];
str4=['球形性=',num2str(th4)];
str5=['圆形性=',num2str(th5)];
str6=['偏心率=',num2str(th6)];
str7=['形状参数=',num2str(th7)];
str8=['矩形度=',num2str(th8)];
%str9=['等二阶矩椭圆长短轴比=',num2str(th9)];
%gtext(str1)
%gtext(str2)
%gtext(str3)
%gtext(str4)
%gtext(str5)
%gtext(str6)
%gtext(str7)
%gtext(str8)
