%% 使用Libsvm对图像进行多分类
tic
clc
clear all
%%
load traindata4.mat
load testdata.mat
TrainX1=traindata(1:500,:);
TrainX2=traindata(501:1000,:);
TrainX3=traindata(1001:1500,:);
TrainX=[TrainX2;TrainX1(1:2:end,:);TrainX3(1:2:end,:)];
m=size(TrainX,1);
TrainY=[2*ones(m/2,1);ones(m/2,1)];
% model=svmtrain(trainlabels,traindata,'-c 0.01 -g 1');
model=svmtrain(TrainY,TrainX);
testdata=Data;
m1=size(testdata,1);
testlabels=ones(m1,1);
[predict_label, accuracy] = svmpredict(testlabels,testdata,model);
Labels1=predict_label;
Ind=find(Labels1==2);toc
%%
TrainX=[TrainX1;TrainX3];
TrainY=[ones(m/2,1);3*ones(m/2,1)];
model=svmtrain(TrainY,TrainX);
[predict_label, accuracy] = svmpredict(testlabels,testdata,model);
Labels2=predict_label;
Labels2(Ind)=2;
Labels=Labels2;
%%
toc