function num = matchstep2(im1, im2,des1,des2,loc1,loc2)
distRatio = 0.35;
thresh = 0.5;
tic
choice=input('Chose 1 for dot product or 2 for Euclidean distance-->');
% For each descriptor in the first image, select its match to second image.
switch choice
    case 1
des2t = des2';                          % Precompute matrix transpose
Neigh=input('Choose 1 for ratio between first and second neighbor or 2 for thresholding on nearest neighbor-->');
for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
    switch (Neigh)
    case 1
   if (vals(1) < distRatio * vals(2))
      match(i) = indx(1);
   else
      match(i) = 0;
   end
   case 2
       if (vals(1) < distRatio)
      match(i) = indx(1);
   else
      match(i) = 0;
       end
    end 
end
    case 2
des2t = des2';
Neigh=input('Choose 1 for ratio between first and second neighbor or 2 for thresholding on nearest neighbor-->');
for i = 1 : size(des1,1)
    des1E=repmat(des1(i,:)',1,size(des2,1));
    Eucli=sum((des1E-des2t).^2,1);% Euclidean distance
   [vals,indx] = sort(Eucli);  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   switch (Neigh)
    case 1
   if (vals(1) < distRatio * vals(2))
      match(i) = indx(1);
   else
      match(i) = 0;
   end
   case 2
       if (vals(1) < distRatio)
      match(i) = indx(1);
   else
      match(i) = 0;
       end
    end 
end
    case 3
  disp('Error please run the code again and choose either 1 or 2')
end
% Create a new image showing the two images side by side.
im3 = appendimages(im1,im2);

% Show a figure with lines joining the accepted matches.
figure('Position', [100 100 size(im3,2) size(im3,1)]);
colormap('gray');
imagesc(im3);
hold all;
cols1 = size(im1,2); colors = {'b','g','r','c','m','y','k','w'}; 
for i = 1: size(des1,1)
  if (match(i) > 0)
    line([loc1(i,2) loc2(match(i),2)+cols1], ...
         [loc1(i,1) loc2(match(i),1)], 'Color', colors{round(7*rand(1)+1)} );
  end
end
hold off;
num = sum(match > 0);
fprintf('Found %d matches.\n', num);
toc



