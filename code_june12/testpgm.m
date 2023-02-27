clear;
clc;
close all;
%%

load net;
[fname,path]=uigetfile('*.jpg');
if fname==0
    return;
end

im=imread(fullfile(path,fname));
im=imresize(im,[149,131]);

classPred = classify(net,im);
labelPred = predict(net,im);
[maxv,index]=max(labelPred);
if index==1
    disp('Benign');
else
    disp('Malignant');
end
%%


