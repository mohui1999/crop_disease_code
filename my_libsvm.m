%% 使用Libsvm对图像进行多分类
tic
clc
clear
%% 
load traindata.mat
m=size(traindata,1);
trainlabels=[ones(m/4,1);2*ones(m/4,1);3*ones(m/4,1);4*ones(m/4,1);];
%%
model=svmtrain(trainlabels,traindata);
%%
load testdata15yang.mat
m1=size(testdata,1);
testlabels=[ones(m1/4,1);2*ones(m1/4,1);3*ones(m1/4,1);4*ones(m1/4,1);];
%%
for i=1:length(testlabels)
    predict_label(i) = svmpredict(testlabels(i),testdata(i,1:end),model);
end
% [predict_label] = libsvmpredict(testlabels,testdata,model);
 Labels=predict_label;
save Label15yang Labels
%%
toc