%% Prepare Workspace
clc;
close all;
warning off all;
%% input 
[fname,path]=uigetfile('Test/*.jpg');
if fname==0
    return;
end
im=imread(fullfile(path,fname)); 
%% Exract feature
featureVector=ExtractimFeatures(im)';
%% test svm
load model;
%
%gp = svmclassify(model,abs(featureVector)');
gp = predict(model,abs(featureVector)');
if gp==1
    disp('Malignant');
else
    disp('Benign');
end
