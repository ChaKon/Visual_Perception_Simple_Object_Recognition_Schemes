% 3.2 for Online component
current = pwd;  % Get the current directory
ftrain = [current '\subset_train\'];  % Full path to the subset train folder
ftest = [current '\subset_testpng\'];  % Full path to the subset test folder
addpath(ftrain);
addpath(ftest);
imdirtrain = dir([ftrain '*.png']);  % Get the elements .png of the train set
imdirtest = dir([ftest '*.png']);  % Get the elements .png of the test set
detector = 'hesaff';  % Detector to be used: hesaff,haraff,heslap,harlap,harhes
descriptor = 'sift';  % Descriptor to be used: sift,goh
%Obtain the total number of matches for each one of the test images with the training images
for i=1:size(imdirtest,1)    % For every test image
name = [ftest imdirtest(i).name];  % get the name of the image
imname = [' -i "' name '"'];    
output = [' -o2 "' name  '.' detector  '.' descriptor  '"'];  % name of the output txt file with the descriptors
%Create features for the test clase if they are not already stored in a file
newfile = fopen(['.\subset_test\' imdirtest(i).name '.' detector '.' descriptor],'r');
if newfile ==-1
command = ['!extract_features -' detector imname ' -' descriptor output];
eval(command)
else
fclose(newfile);
end
% imf2=imdirtest(i).name;
% file2=[imdirtest(i).name '.' detector '.' descriptor];
%Get the number of matches of one image with the other images
for j=1:size(imdirtrain,1)
fprintf('Image %d/%d, Training %d/%d ',i,size(imdirtest,1),j,size(imdirtrain,1));
% imf1=imdirtrain(j).name;
% file1=[imdirtrain(i).name '.' detector '.' descriptor];
fprintf('Image %d/%d, Training %d/%d ',i,size(imdirtest,1),j,size(imdirtrain,1));   
num(i,j) = getparam(['.\subset_train\' imdirtrain(j).name '.' detector '.' descriptor], ...
['.\subset_train\' imdirtrain(j).name], ...
['.\subset_testpng\' imdirtest(i).name '.' detector '.' descriptor], ...
['.\subset_testpng\' imdirtest(i).name],13,'lowe', 'T','No'); 
% num(i,j)=getparam(file1,imf1,file2,imf2,5,'lowe','NNr')
end
end
%Displays the images of the most likely matches
fprintf('\nMost likely matches: \n')
for i=1:11
[maxim Ntrain] = max(num(i,:));  % Most likely match for every test image
fprintf('%s with %s\n',imdirtest(i).name,imdirtrain(Ntrain).name)
getparam(['.\subset_train\' imdirtrain(Ntrain).name '.' detector '.' descriptor], ...
['.\subset_train\' imdirtrain(Ntrain).name], ...
['.\subset_testpng\' imdirtest(i).name '.' detector '.' descriptor], ...
['.\subset_testpng\' imdirtest(i).name],13,'lowe', 'T','Do');
end
goodmat = 4;  %Number of top matches to be shown
fprintf('\n%d most likely matches, in order: \n',goodmat) 
for i=1:11
fprintf('\nFor %s:',imdirtest(i).name)
sortnum = sort(num(i,:),2,'descend');  %Order the matching "list"
for j=1:goodmat
Ntrain = find(num(i,:) == sortnum(j));  %Find the n top matches
for n=1:length(Ntrain)
fprintf('\n\t%d: %s with %d matches',j,imdirtrain(Ntrain(n)).name,sortnum(j))
 end
end
fprintf('\n')
end