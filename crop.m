clc      %清除命令行窗口
clear    %从工作区中删除项目、释放系统内存
I=imread('15.jpg');  %从图形文件读取图像
%It=imcrop(I,[xmin ymin width-1 height-1]);
%(xmin,ymin)要裁剪图片的左上角坐标，width，height是要裁剪成图片的大小
It=imcrop(I,[823,1082,49,59]);  
%利用裁剪函数裁剪图像，其中，（a,b）表示裁剪后
%左上角像素在原图像中的位置；c表示裁剪后图像的宽，d表示裁剪后图像的高
T=extractz(It,1,60,1,50);   %extractz.m文件