clc
clear
I1=imread('15.jpg');
I2=imread('17.jpg');
s1=extractz(I1,1016,1037,2025,2064);
s2=extractz(I1,523,545,1880,1906);
s3=extractz(I1,2957,2998,1155,1186);
s4=extractz(I2,611,632,4789,4828);
S=[s1;s2;s3;s4];
num1=size(S,1)

g1=extractz(I1,432,529,553,662);
g2=extractz(I1,1138,1186,953,1004);
g3=extractz(I1,2831,2890,922,995);
g4=extractz(I2,1197,1242,830,875);
G=[g1;g2;g3;g4];
num2=size(G,1)

y1=extractz(I1,325,421,2107,2257);
y2=extractz(I1,3541,3619,1649,1717);
y3=extractz(I2,393,505,5839,5945);
Y=[y1;y2;y3];
num3=size(Y,1)

t1=extractz(I1,3500,3548,6902,6940);
t2=extractz(I1,731,753,5427,5465);
t3=extractz(I2,2002,2034,1589,1649);
t4=extractz(I2,710,758,1185,1251);
T=[t1;t2;t3;t4];
num4=size(T,1)

Ind1=(randperm(num1))';
Num=500;
Data1=S(Ind1(1:Num),:);
Ind2=(randperm(num2)');
Data2=G(Ind2(1:Num),:);
Ind3=(randperm(num3)');
Data3=Y(Ind3(1:Num),:);
Ind4=(randperm(num4)');
Data4=T(Ind4(1:Num),:);

traindata=[Data1;Data2;Data3;Data4];
save traindata traindata