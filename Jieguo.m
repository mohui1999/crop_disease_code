%% ����Ԥ��ı�ǩ�������ս��ͼ����ʾ
tic
clc
clear 
close all
%%
load Label17ce.mat;%�����ѷ����ǩ
y=uint8(Labels);
y(y==1)=0; y(y==2)=80;y(y==3)=160; y(y==4)=255;
out=(reshape(y,1197,1197))';%(��/2)*(��/2) ��������
figure,imshow(out);
imwrite(out,'c:\Users\Administrator\Desktop\kmeans17ce.png');
toc