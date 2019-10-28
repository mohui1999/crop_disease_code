%% 使用Libsvm对图像进行多分类
tic
clc
clear
%% 
load traindata.mat
traindata=Y;
m=size(traindata,1);
trainlabels=[ones(m/4,1);2*ones(m/4,1);3*ones(m/4,1);4*ones(m/4,1);];
%%
model=libsvmtrain(trainlabels,traindata);
%%
load testdata.mat
testdata=X;
m1=size(testdata,1);
testlabels=[ones(m1/4,1);2*ones(m1/4,1);3*ones(m1/4,1);4*ones(m1/4,1);];
%%
% for i=1:length(testlabels)
%     predict_label(i) = libsvmpredict(testlabels(i),testdata(i,1:end),model);
% end
[predict_label] = libsvmpredict(testlabels,testdata,model);
Labels=predict_label;
save Label Labels
%%
toc