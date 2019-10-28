clc
clear
tic
I=imread('17ce.jpg');
I1=imcrop(I,[1,1,2392,2392]);
%%I2=imcrop(I,[1,2272,6992,4470]);
%%testdata=extractz(I2,1,2200,1,6993);
testdata=extractz(I1,1,2393,1,2393);
save testdata17ce testdata
toc