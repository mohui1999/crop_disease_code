%% ������ɫ
function f=setcolor(A)
[m,n]=size(A);
f=uint8(zeros(m,n,3));
for i=1:m
    for j=1:n
     if A(i,j)==0 
         f(i,j,1)=0;%110
         f(i,j,2)=0;%120
         f(i,j,3)=255;%90  %�����ص�Ϊ��ɫʱ��rgbͨ��ȫΪ0
%      else if A(i,j)==255
%          f(i,j,1)=0;%150
%          f(i,j,2)=0;%120
%          f(i,j,3)=0;%90  %�������ص��ǻ�ɫ��ʱ�����ص�����Ϊǳ��ɫ
%          end
     end
    end
end