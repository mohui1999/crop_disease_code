%% 设置颜色
function f=setcolor(A)
[m,n]=size(A);
f=uint8(zeros(m,n,3));
for i=1:m
    for j=1:n
     if A(i,j)==0 
         f(i,j,1)=0;%110
         f(i,j,2)=0;%120
         f(i,j,3)=0;%90  %当像素点为黑色时，rgb通道全为0
     else if A(i,j)==80
         f(i,j,1)=65;%150
         f(i,j,2)=239;%120
         f(i,j,3)=197;%90  %当该像素点是灰色的时候，像素点设置为浅蓝色
     else if A(i,j)==255
         f(i,j,1)=0;%200
         f(i,j,2)=0;%170
         f(i,j,3)=255;%130 %当该像素点为白色时，像素点设为蓝色
    else 
         f(i,j,1)=65;%90
         f(i,j,2)=239;%180
         f(i,j,3)=197;%60%浅蓝色 %此处像素值与上面像素值为80的像素值设置一样

     end
    end
end
end;
end