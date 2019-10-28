close all; 
clear; 
clc; 
format compact; 
%% 读取图像
pic = imread('15ce.jpg'); 
pic = imresize(pic,[2400,2400]);%测试15ce.jpg,17ce.jpg两张测试图片时resize成2400*2400(当测试图片大小不是本文中要做标签6个的倍数时用imresize)
figure; 
imshow(pic); 
%% 选定训练集合测试集 
TrainData_bad1 = zeros(100,3,'double'); 
TrainData_bad2 = zeros(100,3,'double'); 
TrainData_health1 = zeros(100,3,'double');
TrainData_health2 = zeros(100,3,'double');
TrainData_black = zeros(100,3,'double');
TrainData_other = zeros(100,3,'double'); 
% 采样 
msgbox('Please separate bad1 samples','bad1 Samples','help'); 
pause; 
[x,y] = ginput(2); 
hold on; 
plot(x,y,'r*'); 
x = uint16(x); 
y = uint16(y); 
TrainData_bads1 = pic(y(1):y(2),x(1):x(2),1:3); 
[X,Y,P] = size(TrainData_bads1); 
run = 1; 
for i = 1:X 
for j = 1:Y 
TrainData_bad1(run,1) = TrainData_bads1(i,j,1); 
TrainData_bad1(run,2) = TrainData_bads1(i,j,2); 
TrainData_bad1(run,3) = TrainData_bads1(i,j,3); 
run = run+1; 
end 
end 
randindex = randperm(X*Y);% 这个是1到X*Y的随机组合 
TrainData_bad1 = TrainData_bad1(randindex(1:100),:);

msgbox('Please separate bad2 samples','bad2 Samples','help'); 
pause; 
[x,y] = ginput(2); 
hold on; 
plot(x,y,'r*'); 
x = uint16(x); 
y = uint16(y); 
TrainData_bads2 = pic(y(1):y(2),x(1):x(2),1:3); 
[X,Y,P] = size(TrainData_bads2); 
run = 1; 
for i = 1:X 
for j = 1:Y 
TrainData_bad2(run,1) = TrainData_bads2(i,j,1); 
TrainData_bad2(run,2) = TrainData_bads2(i,j,2); 
TrainData_bad2(run,3) = TrainData_bads2(i,j,3); 
run = run+1; 
end 
end 
randindex = randperm(X*Y);% 这个是1到X*Y的随机组合 
TrainData_bad2 = TrainData_bad2(randindex(1:100),:);

msgbox('Please separate health1 samples','health1 Samples','help'); 
pause; 
[x,y] = ginput(2); 
hold on; 
plot(x,y,'r*'); 
x = uint16(x); 
y = uint16(y); 
TrainData_healths1 = pic(y(1):y(2),x(1):x(2),1:3); 
[X,Y,P] = size(TrainData_healths1); 
run = 1; 
for i = 1:X 
for j = 1:Y 
TrainData_health1(run,1) = TrainData_healths1(i,j,1); 
TrainData_health1(run,2) = TrainData_healths1(i,j,2); 
TrainData_health1(run,3) = TrainData_healths1(i,j,3); 
run = run+1; 
end 
end 
randindex = randperm(X*Y);% 这个是1到X*Y的随机组合 
TrainData_health1 = TrainData_health1(randindex(1:100),:);

msgbox('Please separate health2 samples','health2 Samples','help'); 
pause; 
[x,y] = ginput(2); 
hold on; 
plot(x,y,'r*'); 
x = uint16(x); 
y = uint16(y); 
TrainData_healths2 = pic(y(1):y(2),x(1):x(2),1:3); 
[X,Y,P] = size(TrainData_healths2); 
run = 1; 
for i = 1:X 
for j = 1:Y 
TrainData_health2(run,1) = TrainData_healths2(i,j,1); 
TrainData_health2(run,2) = TrainData_healths2(i,j,2); 
TrainData_health2(run,3) = TrainData_healths2(i,j,3); 
run = run+1; 
end 
end 
randindex = randperm(X*Y);% 这个是1到X*Y的随机组合 
TrainData_health2 = TrainData_health2(randindex(1:100),:);

msgbox('Please separate black samples','black Samples','help'); 
pause; 
[x,y] = ginput(2); 
hold on; 
plot(x,y,'g.') 
x = uint16(x); 
y = uint16(y); 
TrainData_blacks = pic(y(1):y(2),x(1):x(2),1:3); 
[X,Y,P] = size(TrainData_blacks); 
run = 1; 
for i = 1:X 
for j = 1:Y 
TrainData_black(run,1) = TrainData_blacks(i,j,1); 
TrainData_black(run,2) = TrainData_blacks(i,j,2); 
TrainData_black(run,3) = TrainData_blacks(i,j,3); 
run = run+1; 
end 
end 
randindex = randperm(X*Y);% 这个是1到X*Y的随机组合 
TrainData_black = TrainData_black(randindex(1:100),:);

msgbox('Please separate other samples','other Samples','help'); 
pause; 
[x,y] = ginput(2); 
hold on; 
plot(x,y,'b*') 
x = uint16(x); 
y = uint16(y); 
TrainData_others = pic(y(1):y(2),x(1):x(2),1:3); 
[X,Y,P] = size(TrainData_others); 
run = 1; 
for i = 1:X 
for j = 1:Y 
TrainData_other(run,1) = TrainData_others(i,j,1); 
TrainData_other(run,2) = TrainData_others(i,j,2); 
TrainData_other(run,3) = TrainData_others(i,j,3); 
run = run+1; 
end 
end 
randindex = randperm(X*Y);% 这个是1到X*Y的随机组合 
TrainData_other = TrainData_other(randindex(1:100),:);

% 确定训练集和训练标签 
pic1(1:100,1) = 1; 
pic2(1:100,1) = 2; 
pic3(1:100,1) = 3;      
pic4(1:100,1) = 4;
pic5(1:100,1) = 5;
pic6(1:100,1) = 6;
Train_label = [pic1;pic2;pic3;pic4;pic5;pic6]; 
Train_data = [TrainData_bad1;TrainData_bad2;TrainData_health1;TrainData_health2;TrainData_black;TrainData_other]; 
% 确定测试集和测试标签 
[X,Y,P] = size(pic); 
TestData = zeros(X*Y,3,'double'); 
k = 1; 
for i = 1:X 
for j = 1:Y 
TestData(k,1) = pic(i,j,1); 
TestData(k,2) = pic(i,j,2); 
TestData(k,3) = pic(i,j,3); 
k = k+1; 
end 
end 
Test_data =TestData; 
Test_label = [ones(length(TestData)/6,1);2*ones(length(TestData)/6,1);3*ones(length(TestData)/6,1);4*ones(length(TestData)/6,1);5*ones(length(TestData)/6,1);6*ones(length(TestData)/6,1)]; 
%% 建模预测 
% 利用训练集合建立分类模型 
model = svmtrain(Train_label,Train_data,'-c 1 -g 0.2 b 1'); 
[predict_label,accuracy,decision_values] = svmpredict(Test_label,Test_data,model); 
%% 分类可视化 
result=zeros(X,Y,3); % RGB彩图 
for k=1:X*Y % R分量 G分量 B分量 
if (predict_label(k,1)==1) Test_data(k,1)=207;Test_data(k,2)=65;Test_data(k,3)=239; % 紫色
elseif(predict_label(k,1)==2) Test_data(k,1)=207;Test_data(k,2)=65;Test_data(k,3)=239; % 紫色
elseif(predict_label(k,1)==3) Test_data(k,1)=65;Test_data(k,2)=239; Test_data(k,3)=197; % 浅蓝色
elseif(predict_label(k,1)==4) Test_data(k,1)=65;Test_data(k,2)=239; Test_data(k,3)=197; % 浅蓝色
elseif(predict_label(k,1)==5) Test_data(k,1)=0;Test_data(k,2)=0; Test_data(k,3)=0; % 黑色
elseif(predict_label(k,1)==6)  Test_data(k,1)=0; Test_data(k,2)=0; Test_data(k,3)=0; % 黑色 
end 
end  
k=1; 
for i = 1:X
for j=1:Y 
result(i,j,1)=Test_data(k,1); 
result(i,j,2)=Test_data(k,2); 
result(i,j,3)=Test_data(k,3); 
k=k+1; 
end  
end 
result=uint8(result); 
figure;imshow(result);
imwrite(result,'F:\UU\lunwennn\result2\result_svm\svm15cepurple.png');
%以下为去孔洞
%im=rgb2gray(result);
%im = imfill(im,'holes');
%figure;imshow(im);
%原文：https://blog.csdn.net/xiaozhouchou/article/details/50827893 