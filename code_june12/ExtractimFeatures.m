function fet=ExtractimFeatures(Im)
global  G
Im=imresize(Im,[149,131]);
% figure,imshow(Im,'initialmagnification','fit');
% title('input image');
%% Preprocessing
if size(Im,3)==3
G=rgb2gray(Im);
else
    G=Im;
end

% figure,imshow(uint8(G),'initialmagnification','fit');
% title('Intensity image');
%% filtering
[M,N]=size(G);
G=medfilt2(G,[3,3]);
% figure,imshow(uint8(G),'initialmagnification','fit');
%% Kmeans
vector=double(G(:));
k=3;
s=kmeans(vector,k,'Replicates',5);
vector_image=reshape(s,size(G,1),size(G,2));
vector_image=uint8(vector_image);
l1=length(find(vector_image==1));
l2=length(find(vector_image==2));
l3=length(find(vector_image==3));
[m index]=min([l1 l2 l3]);
if m<=1500
vector_image(find(vector_image==index))=234;
end
% figure,imshow(vector_image,'initialmagnification','fit');
%% Skull removal
[M,N]=size(G);
G=medfilt2(G);
% figure,imshow(G,'initialmagnification','fit');
%% binarization using otsu method
th=graythresh(G);
B=im2bw(G,th);
% figure,imshow(B,'initialmagnification','fit');
% title('Binarization Result');
%% morphological operation
SE = strel('periodicline', 2,[1 2]); %
B=imopen(B,SE);
% figure,imshow(B,'initialmagnification','fit');
% title('After morphological opening operation');
B=bwareaopen(B,1200);
B=bwmorph(B,'erode');
B=imfill(B,'holes');
% figure,imshow(B,'initialmagnification','fit');
% title('After erosion');

%%  find tumor
vector_image=vector_image.*uint8(B);
vector_image=vector_image>=230;
vector_image=bwareaopen(vector_image,50);
% figure,imshow(vector_image,'initialmagnification','fit');
%%  extract features
%select region of interest
G=double(G);
ROI=zeros(M,N);
ROI(B)=G(B);
% glcm
%Create gray-level co-occurrence matrix from image
glcm = graycomatrix(ROI);
%Properties of gray-level co-occurrence matrix
stats = graycoprops(glcm,'all');
%find glcm features
%Contrast
Contrast=stats.Contrast;
%Correlation
Correlation=stats.Correlation;
%Energy
Energy=stats.Energy;
%.homogeneity
Homogeneity=stats.Homogeneity;
%% area
A=nnz(B)/numel(B);


Mean = mean2(ROI);
Standard_Deviation = std2(ROI);
Entropy = entropy(ROI);
RMS = mean2(rms(ROI));
Variance = mean2(var(double(ROI)));
a = sum(double(ROI(:)));
Smoothness = 1-(1/(1+a));
Kurtosis = kurtosis(double(ROI(:)));
Skewness = skewness(double(ROI(:)));
% Inverse Difference Movement
m = size(ROI,1);
n = size(ROI,2);
in_diff = 0;
for i = 1:m
    for j = 1:n
        temp = ROI(i,j)./(1+(i-j).^2);
        in_diff = in_diff+temp;
    end
end
IDM = double(in_diff);
    
fet=[Contrast,Correlation,Energy,Homogeneity,A,Mean, Standard_Deviation, Entropy, RMS, Variance, Smoothness, Kurtosis, Skewness, IDM];

