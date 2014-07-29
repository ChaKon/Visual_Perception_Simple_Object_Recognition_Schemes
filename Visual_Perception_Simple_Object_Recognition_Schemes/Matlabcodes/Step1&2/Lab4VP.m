close all;
clear all;
%% STEP 1
% % image1=imread('images\subset_train\object0016.view01.png'); % reading
% % image for our convinent to see the input image
imstp1='images\subset_train\object0002.view02.png';
% % imag2=imread('images\subset_train\object0016.view04.png');% reading
% % image for our convinent to see the input image
imstp2='images\subset_train\object0002.view03.png';
% Question 1.2
[im1, des1, loc1] = sift(imstp1);
[im2, des2, loc2] = sift(imstp2);
showkeys(im1, loc2);
showkeys(im2, locs2);
% Question 1.3
% im1=imread('images\subset_train\object0016.view01.png');
% im2=imread('images\subset_train\object0016.view04.png');

num = matchstep2(im1, im2,des1,des2,loc1,loc2)
% num_Eucli = match(imstp1, imstp2)
% For image object0016.view01.png and object0016.view04.png the matches
% are 2
% For image object0016.view01.png and object0016.view02.png the matches
% are 1064
% QUESTION 1.4
% By using the Euclidean distance than the dot product the matching points
% increases in case of object0016.view01.png and object0016.view04.png but
% computationally expensive
% QUESTION 1.5
% Changing the distance ratio. As we increase the distance ratio to 0.9-1
% there will be more increase in the matches in this there are many
% mismatches. If we decrease the distratio the matches found will be less.
% Apart from this lowe used to find the match using dotproduct of distRatio and vals it gives
% good matching results but if we use only some distRatio it leads to more
% miss matches.
%% STEP 2
disp('Now for STEP 2');
% Before runing this code make sure that all .m files and images are in
% same folder ex: In E:\Education\2nd Semester\LAB WORKS\Visual Perception\Labs\Lab 4
% it should contain extract_features.exe, .m files like display features
% etc and images
image1 =uigetfile('E:\Education\2nd Semester\LAB WORKS\Visual Perception\Labs\Lab 4\*.png');
% image1=imread(image1);
output1 = [image1 '.' 'desc'];
% system(['extract_features.exe -haraff -i ' image1 ' -sift -pca harhessift.basis -o1 ' output1]);
image2=uigetfile('E:\Education\2nd Semester\LAB WORKS\Visual Perception\Labs\Lab 4\*.png');
% image2=imread(image2);
output2=[image2 '.' 'desc'];
disp('press 1 for harris-affine detector');
disp('press 2 for hessian-affine detector');
disp('press 3 for harris-hessian-laplace detector');
disp('press 4 for harris laplace detector');
disp('press 5 for hessian laplace detector');
off_detector=input('choose detector you want-->');
switch off_detector
    case 1
        disp('Harris detector is choosed');
        pause(0.02);
system(['extract_features.exe -haraff -i ' image1 ' -sift -pca harhessift.basis -o1 ' output1]);
system(['extract_features.exe -haraff -i ' image2 ' -sift -pca harhessift.basis -o1 ' output2]);
    case 2
        disp('Hessian affine detector is choosed');
        pause(0.02);
system(['extract_features.exe -hesaff -i ' image1 ' -sift -pca harhessift.basis -o1 ' output1]);
system(['extract_features.exe -hesaff -i ' image2 ' -sift -pca harhessift.basis -o1 ' output2]);
    case 3
        disp('harris-hessian-laplace detector is choosed');
        pause(0.02);
system(['extract_features.exe -harhes -i ' image1 ' -sift -pca harhessift.basis -o1 ' output1]);
system(['extract_features.exe -harhes -i ' image2 ' -sift -pca harhessift.basis -o1 ' output2]);
    case 4
        disp('harris laplace detector is choosed');
        pause(0.02);
system(['extract_features.exe -harlap -i ' image1 ' -sift -pca harhessift.basis -o1 ' output1]);
system(['extract_features.exe -harlap -i ' image2 ' -sift -pca harhessift.basis -o1 ' output2]);
    case 5
        disp('hessian-laplace detector is choosed');
        pause(0.02);
system(['extract_features.exe -heslap -i ' image1 ' -sift -pca harhessift.basis -o1 ' output1]);
system(['extract_features.exe -heslap -i ' image2 ' -sift -pca harhessift.basis -o1 ' output2]);
end
file1=output1;
file2=output2;
imf1=imread(image1);
imf2=imread(image2);
% display_features(file1,imf1,0,0)
% display_features(file2,imf2,0,0)
% For displaying the features just uncomment this part this conversion from
% rgbtogray for matching
if size(imf1,3)>1
    imf1=rgb2gray(imf1);
end
if size(imf2,3)>1
    imf2=rgb2gray(imf2);
end
numdes=5;
[des1 nb1 dim1] = loadFeatures(file1,numdes);
[des2 nb2 dim2] = loadFeatures(file2,numdes);
% geting the x,y location
loc1=des1(1:2,:)';
loc1=fliplr(loc1);
loc2=des2(1:2,:)';
loc2=fliplr(loc2);
% normalizing the features
des1=des1(numdes+1:end,:);
des1=des1';
des1 = diag([1./sqrt(diag(des1*des1'))])*des1;
des2=des2(numdes+1:end,:);
des2=des2';
des2 = diag([1./sqrt(diag(des2*des2'))])*des2;
num = matchstep2(imf1, imf2,des1,des2,loc1,loc2)

%% STEP 3
% 3.1 all data set of images are downloaded
% 3.2 Offline component for training 
P_W_dir = pwd; % present working directory
im_num={'02','03','04','05','06','07','16'}; % the image numbers for differnt views
off_detector='hesaff';
off_descriptor='sift';
for l=1:size(im_num,2)
    for m=1:5 % for five views
        cd('E:\Education\2nd Semester\LAB WORKS\Visual Perception\Labs\Lab 4\subset_train\');
        file=['object00' im_num{l} '.view0' num2str(m) '.png'];
%         img_name=[' file '];
        out_img=[file '.''desc'];
        system(['extract_features.exe -haraff -i ' file ' -sift -pca harhessift.basis -o1 ' out_img]);
    end
end
cd(P_W_dir);
im_num_test={'44','45','46','47','48','49','50','51','52','53','57'}; % the image numbers for differnt views
offtest_detector='hesaff';
offtest_descriptor='sift';
for j=1:size(im_num_test,2) % for all test images
        cd('E:\Education\2nd Semester\LAB WORKS\Visual Perception\Labs\Lab 4\subset_testpng\');
        file=['qimg00' im_num_test{j} '.png'];
        out_img=[file '.''desc'];
        system(['extract_features.exe -haraff -i ' file ' -sift -pca harhessift.basis -o1 ' out_img]);
end
cd(P_W_dir);

%%
% Optional
% current=pwd;
% train = [current '\subset_train\'];  % Full path to the subset train folder
% test = [current '\subset_testpng\'];  % Full path to the subset test folder
% dir_train = dir([train '*.png']);  % Get the elements .png of the train set
% dir_test = dir([test '*.png']);  % Get the elements .png of the test set
% off_detector = 'hesaff';  % Detector to be used: hesaff,haraff,heslap,harlap,harhes
% off_descriptor = 'sift';  % Descriptor to be used: sift,goh
% %Obtain the total number of matches for each one of the test images with the training images
% 
% for i=1:size(dir_test,1)    % For every test image
% name = [test dir_test(i).name];  % get the name of the image
% img_name = [' -i "' name '"'];    
% out_img = [' -o2 "' name  '.' off_detector  '.' off_descriptor  '"'];
% command = ['!extract_features -' off_detector img_name ' -' off_descriptor out_img];
% eval(command)
% end
% P_W_dir = pwd; % present working directory
% train = [current '\subset_train\'];  % Full path to the subset train folder
% test = [current '\subset_testpng\'];  % Full path to the subset test folder
% dir_train = dir([train '*.png']);  % Get the elements .png of the train set
% dir_test = dir([test '*.png']);  % Get the elements .png of the test set
% im_num={'02','03','04','05','06','07','16'}; % the image numbers for differnt views
% offtrain_detector='hesaff';
% offtrain_descriptor='sift';
% for l=1:size(im_num,2)
%     for m=1:5 % for five views
%         cd('E:\Education\2nd Semester\LAB WORKS\Visual Perception\Labs\Lab 4\subset_train\');
%         name = [ftrain 'object00' im_num{l} '.view0' num2str(m) '.png'];  % Name of the image
%         imname = [' -i "' name '"'];  % Format for the name
%         output = [' -o2 "' name '.' offtrain_detector '.' offtrain_descriptor '"'];
%         command = ['!extract_features -' offtrain_detector imname ' -' offtrain_descriptor output];
%         eval(command)
%     end
% end
% cd(P_W_dir);
