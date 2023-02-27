clear;
clc;
close all;
%%
path1='./data/Benign';
path2='./data/Malignant';

images=dir([path1,'/','*.jpg']);
for i=1:length(images)
    imagename=images(i).name;
    I=imread([path1,'/',imagename]);
    I=imresize(I,[149,131]);
    imwrite(I,[path1,'/',imagename]);
end

images=dir([path2,'/','*.jpg']);
for i=1:length(images)
    imagename=images(i).name;
    I=imread([path2,'/',imagename]);
    I=imresize(I,[149,131]);
    imwrite(I,[path2,'/',imagename]);
end
fprintf('TRAIN Dataset preparation done');
%%
path3='./test/Benign';
path4='./test/Malignant';

images=dir([path3,'/','*.jpg']);
for i=1:length(images)
    imagename=images(i).name;
    I=imread([path3,'/',imagename]);
    I=imresize(I,[149,131]);
    imwrite(I,[path3,'/',imagename]);
end

images=dir([path4,'/','*.jpg']);
for i=1:length(images)
    imagename=images(i).name;
    I=imread([path4,'/',imagename]);
    I=imresize(I,[149,131]);
    imwrite(I,[path4,'/',imagename]);
end
fprintf('TEST Dataset preparation done');

