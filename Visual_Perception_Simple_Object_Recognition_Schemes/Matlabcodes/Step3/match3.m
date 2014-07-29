function num = match3(im1, im2,des1,des2,loc1,loc2,method,neigh,need)
distRatio = 0.3;
% For each descriptor in the first image, select its match to second image.
if method =='lowe'
des2t = des2';                          % Precompute matrix transpose
for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if neigh == 'L'
       if (vals(1) < distRatio * vals(2))
       match(i) = indx(1);
       else
       match(i)=0;
       end
   elseif neigh=='T'
       if (vals(1) < distRatio)
       match(i) = indx(1);
       else
       match(i) = 0;
       end
   end
end

elseif method=='Eucli'
    for i = 1 : size(des1,1)
    des1E=repmat(des1(i,:)',1,size(des2,1));
    Eucli=sum((des1E-des2t).^2,1);% Euclidean distance
   [vals,indx] = sort(Eucli);  % Take inverse cosine and sort results
    if neigh =='L'
        if (vals(1) < distRatio * vals(2))
        match(i) = indx(1);
        else
        match(i) = 0;
        end
    elseif neigh =='T'
       if (vals(1) < distRatio)
       match(i) = indx(1);
       else
       match(i) = 0;
       end
    end
    end
end
if need=='No'
% Create a new image showing the two images side by side.

% 
% % Show a figure with lines joining the accepted matches.
% figure('Position', [100 100 size(im3,2) size(im3,1)]);
% colormap('gray');
% imagesc(im3);
% hold all;
% cols1 = size(im1,2);
% for i = 1: size(des1,1)
%   if (match(i) > 0)
%     line([loc1(i,2) loc2(match(i),2)+cols1], ...
%          [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
%   end
% end
% hold off;
num = sum(match > 0);
fprintf('Found %d matches.\n', num);
elseif need=='Do'
im3 = appendimages(im1,im2);
figure('Position', [100 100 size(im3,2) size(im3,1)]);
colormap('gray');
imagesc(im3);
hold all;
cols1 = size(im1,2);
for i = 1: size(des1,1)
  if (match(i) > 0)
    line([loc1(i,2) loc2(match(i),2)+cols1], ...
         [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
  end
end
hold off;
num = sum(match > 0);
fprintf('Found %d matches.\n', num);
else
    disp('No drwawing option was choosed');
    num=NaN;
end



