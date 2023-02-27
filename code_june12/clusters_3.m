
%% Prepare Workspace
clear ; % clear all variables
clc; %clear  command window
close all % close all figure windows
rng('default');
%% Input
wd=256;
[fname,path]=uigetfile('T/*.jpg');
Im=imread(fullfile(path,fname));
%Im = imread('1Perfect.jpg');
Im=imresize(Im,[256,256]);
%imshow(Im);
figure;
if size(Im,3)==3
Im=rgb2gray(Im);
else
    Im=Im;
end

Im =double(Im);
[r c] = size(Im);
Length = r*c; 

Dataset = reshape(Im,[Length,1]);
Clusters=3 %k CLUSTERS
% Cluster1=[];
% Cluster2=[];
% Cluster3=[];
% Cluster4=[];
% Cluster5=[];
Cluster1=zeros(Length,1);
Cluster2=zeros(Length,1);
Cluster3=zeros(Length,1);
% Cluster4=zeros(Length,1);
% Cluster5=zeros(Length,1);
% Initial Centroids
% ARBITARLY CHOOSE K OBJECTS AS INITIAL CENTROIDS
miniv = min(min(Im));
maxiv = max(max(Im));
range = maxiv - miniv;
stepv = range/Clusters;
incrval = stepv;
for i = 1:Clusters
K(i).centroid = incrval;
incrval = incrval + stepv;
end
%BEGIN LOOP
% L=1;
update1=0;
update2=0;
update3=0;
update4=0;
update5=0;
mean1=2;
mean2=2;
mean3=2;
mean4=2;
mean5=2;
while ((mean1 ~= update1) & (mean2 ~= update2) & (mean3 ~= update3) )
mean1=K(1).centroid;
mean2=K(2).centroid;
mean3=K(3).centroid;
% mean4=K(4).centroid;
% mean5=K(5).centroid;
for i=1:Length
for j = 1:Clusters
temp= Dataset(i);
difference(j) = abs(temp-K(j).centroid);

end
[y,ind]=min(difference);

if ind==1
Cluster1(i) =temp;
end
if ind==2
Cluster2(i) =temp;
end
if ind==3
Cluster3(i) =temp;
end
% if ind==4
% Cluster4(i) =temp;
% end
% if ind==5
% Cluster5(i) =temp;
% end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%UPDATE CENTROIDS
cout1=0;
cout2=0;
cout3=0;
cout4=0;
cout5=0;
for i=1:Length
Load1=Cluster1(i);
Load2=Cluster2(i);
Load3=Cluster3(i);
% Load4=Cluster4(i);
% Load5=Cluster5(i);

if Load1 ~= 0
cout1=cout1+1;
end

if Load2 ~= 0
cout2=cout2+1;
end
% 
if Load3 ~= 0
cout3=cout3+1;
end

% if Load4 ~= 0
% cout4=cout4+1;
% end
% 
% if Load5 ~= 0
% cout5=cout5+1;
% end
end
% find the new mean of centroids
% Mean_Cluster(1)=sum(Cluster1)/Length;
% Mean_Cluster(2)=sum(Cluster2)/Length;
% Mean_Cluster(3)=sum(Cluster3)/Length;
% Mean_Cluster(4)=sum(Cluster4)/Length;
% Mean_Cluster(5)=sum(Cluster5)/Length;
Mean_Cluster(1)=sum(Cluster1)/cout1;
Mean_Cluster(2)=sum(Cluster2)/cout2;
Mean_Cluster(3)=sum(Cluster3)/cout3;
% Mean_Cluster(4)=sum(Cluster4)/cout4;
% Mean_Cluster(5)=sum(Cluster5)/cout5;
%reload
for i = 1:Clusters
K(i).centroid = Mean_Cluster(i);
end
update1=K(1).centroid;
update2=K(2).centroid;
update3=K(3).centroid;
% update4=K(4).centroid;
% update5=K(5).centroid;



end
AA1=reshape(Cluster1,[wd wd]);
AA2=reshape(Cluster2,[wd wd]);
AA3=reshape(Cluster3,[wd wd]);
vector_image=AA3;
% AA4=reshape(Cluster4,[wd wd]);
% AA5=reshape(Cluster5,[wd wd]);
subplot(1,3,1);imshow(AA1,[]);
%figure;
subplot(1,3,2);imshow(AA2,[]);
%figure;
subplot(1,3,3);imshow(AA3,[]);
% figure;
% imshow(AA4,[]);
% figure;
% imshow(AA5,[]);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


