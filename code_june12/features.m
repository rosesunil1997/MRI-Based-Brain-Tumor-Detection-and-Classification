 function [fpos, fneg,lenpos,lenneg] = features(pathPos,pathNeg)
% extract features for positive examples

imlist = dir([pathPos '/*.jpg']);
lenpos=length(imlist);
for i = 1:length(imlist)
    im = imread([pathPos,'/', imlist(i).name]);
    fpos{i} = ExtractimFeatures(im)';
end
% extract features for negative examples
imlist = dir([pathNeg '/*.jpg']);
lenneg=length(imlist);
for i = 1:length(imlist)
    im = imread([pathNeg,'/', imlist(i).name]);
    fneg{i} = ExtractimFeatures(im)';
end

end