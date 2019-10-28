clc
clear
I=imread('6.jpg');
testdata=extractz(I,1,497,1,497);
save testdata6 testdata
