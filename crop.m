clc      %��������д���
clear    %�ӹ�������ɾ����Ŀ���ͷ�ϵͳ�ڴ�
I=imread('15.jpg');  %��ͼ���ļ���ȡͼ��
%It=imcrop(I,[xmin ymin width-1 height-1]);
%(xmin,ymin)Ҫ�ü�ͼƬ�����Ͻ����꣬width��height��Ҫ�ü���ͼƬ�Ĵ�С
It=imcrop(I,[823,1082,49,59]);  
%���òü������ü�ͼ�����У���a,b����ʾ�ü���
%���Ͻ�������ԭͼ���е�λ�ã�c��ʾ�ü���ͼ��Ŀ���d��ʾ�ü���ͼ��ĸ�
T=extractz(It,1,60,1,50);   %extractz.m�ļ�