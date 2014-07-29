function num=getparam(file1,im1,file2,im2,NoDescr,method,neigh,need)
im1 = imread(im1);  %Reading image
im2 = imread(im2);  %Reading image
if(size(im1,3)>1)
    im1=rgb2gray(im1);
end  %Convert to grey, if necessary
if(size(im2,3)>1)
    im2=rgb2gray(im2); 
end  
%Read the values of the text file
[des1 nb1 dim1] = loadFeatures(file1,NoDescr);
[des2 nb2 dim2] = loadFeatures(file2,NoDescr);
%Get the vectors x,y for the corners
loc1 = des1(1:2,:)'; 
loc2 = des2(1:2,:)';
loc1 = fliplr(loc1); 
loc2 = fliplr(loc2);
%Normalize the feature vectors
des1 = des1(NoDescr+1:end,:); 
des1 = des1';
des1 = diag([1./sqrt(diag(des1*des1'))])*des1;
des2 = des2(NoDescr+1:end,:); 
des2 = des2';
des2 = diag([1./sqrt(diag(des2*des2'))])*des2; 
num=match3(im1, im2,des1,des2,loc1,loc2,method,neigh,need)
end
