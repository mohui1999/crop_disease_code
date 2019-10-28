function Data=extractz(x,top,bottom,left,right)
f=x;
b=3;
R=f(:,:,1);
G=f(:,:,2);
B=f(:,:,3);
[m,n,~]=size(f);    %数组维度
Y=rgb2gray(f);   %将 RGB 图像或颜色图转换为灰度图
%% 测试区域特征提取
k=0;
for i=top:2:bottom
    for j=left:2:right
        k=k+1;
        fprintf('%d',k);
        P(k,:)=[R(i,j),G(i,j),B(i,j)]; %颜色特征向量P   
        
        if(i<=3)i=4;end
        if(i>bottom-3)i=bottom-4;end
        if(j<=3)j=4;end
        if(j>right-3)j=right-4;end
        chu=Y(i-3:i+3,j-3:j+3);
        %0 方向
        [glcms,SI]=graycomatrix(chu,'GrayLimits',[1 256],'NumLevels',64,'Offset',[0 1]);
        stats = graycoprops(glcms);
        wen1=stats.Energy
        %45 方向
        [glcms,SI]=graycomatrix(chu,'GrayLimits',[1 256],'NumLevels',64,'Offset',[-1 1]);
        stats = graycoprops(glcms); 
        wen2=stats.Energy
        %90 方向
        [glcms,SI]=graycomatrix(chu,'GrayLimits',[1 256],'NumLevels',64,'Offset',[-1 0]);
        stats = graycoprops(glcms);
        wen3=stats.Energy
        %135 方向
        [glcms,SI]=graycomatrix(chu,'GrayLimits',[1 256],'NumLevels',64,'Offset',[-1 -1]);
        stats = graycoprops(glcms);
        wen4=stats.Energy
        %% 计算统计量的均值和标准差
        a1=mean([wen1,wen2,wen3,wen4]);
        Wen(k,:)=a1;       
    end
end
Yan=double(P);
Yan=Yan/255;
%% 综合特征向量
Data=[Yan,Wen];