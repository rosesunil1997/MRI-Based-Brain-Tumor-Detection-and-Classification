clear;
clc;
%%
global imds
imds = imageDatastore('./data', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
aimds = augmentedImageSource([149,131,3],imds, 'ColorPreprocessing', 'gray2rgb');


layers = [ ...
    imageInputLayer([149,131,3])
    convolution2dLayer(5,20)
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];
options = trainingOptions('sgdm', ...
    'MaxEpochs',20,...
    'InitialLearnRate',1e-4, ...
    'Verbose',true, ...
    'Plots','training-progress');

net = trainNetwork(aimds,layers,options);

save net net



