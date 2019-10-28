%% 对已预测的标签进行最终结果图像显示
tic
clc
clear 
close all
%%
load Label17ce.mat;%加载已分类标签
y=uint8(Labels);
y(y==1)=0; y(y==2)=80;y(y==3)=160; y(y==4)=255;
out=(reshape(y,1197,1197))';%(长/2)*(宽/2) 四舍五入
figure,imshow(out);
imwrite(out,'c:\Users\Administrator\Desktop\kmeans17ce.png');
toc