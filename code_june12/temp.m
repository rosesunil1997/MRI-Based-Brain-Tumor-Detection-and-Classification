clear all
clc

[fname,path]=uigetfile('T/*.jpg');
Im=imread(fullfile(path,fname));
Im=imresize(Im,[149,131]);
imshow(Im);
if strcmp(path,'F:\s8_project\backup_code2_apr26\test\Benign\')
    disp('benign')
else
    disp('malignant')
end    