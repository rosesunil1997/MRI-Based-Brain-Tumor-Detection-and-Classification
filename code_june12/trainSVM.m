%% prepare Workspace
clear;
clc;
close all;
%% train svm
fprintf('Training SVM..\n');

[fpos, fneg,lenpos,lenneg] = features('./Benign', './Malignant'); 
P =abs( cell2mat([fpos,fneg])); 
T = [ones(lenpos,1);-ones(lenneg,1)]; 
%model = svmtrain(P, T,'kernel_function','quadratic');
model = fitcsvm(P',T,'Standardize',true,'KernelFunction','RBF');
clc;
fprintf('done. \n');
save model model
