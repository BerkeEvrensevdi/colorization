clear;
% name of the input file
imname = 'turkmen.png';

% read in the image
fullim = imread(imname);

% convert to double matrix
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);

% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

R = crop(R);
G = crop(G);
B = crop(B);


% create a color image (3D array)
rgbNotAligned(:,:,1) = R;
rgbNotAligned(:,:,2) = G;
rgbNotAligned(:,:,3) = B;

figure;imshow(rgbNotAligned); title('not aligned');

rgbAlignedNcc = rgbNotAligned;
redCoord = ncc(R,B);
rgbAlignedNcc(:,:,1) = circshift(R,redCoord);

greenCoord = ncc(G,B);
rgbAlignedNcc(:,:,2) = circshift(G,greenCoord);

rgbAlignedSsd = rgbNotAligned;
coordRed = align(R,B);
coordGreen = align(G,B);
rgbAlignedSsd(:,:,1) = circshift(R,coordRed);
rgbAlignedSsd(:,:,2) = circshift(G,coordGreen);

figure;imshow(rgbAlignedSsd);title('alignedSsd');
figure;imshow(rgbAlignedNcc);title('alignedNcc');
figure;imshowpair(rgbNotAligned,rgbAlignedSsd,'montage');title('not aligned and alignedSsd');
figure;imshowpair(rgbNotAligned,rgbAlignedNcc,'montage');title('not aligned and alignedNcc');

gammaCorrection = imadjust(rgbAlignedNcc,[],[],1.5)
figure;imshowpair(rgbAlignedNcc,gammaCorrection,'montage');title('alignedNcc and Gamma Correction');
figure;imshowpair(rgbAlignedSsd, rgbAlignedNcc,'montage');title('AlignedSsd and AlignedNcc');
histEq = histeq(rgbAlignedNcc);
figure;imshowpair(rgbAlignedNcc,histEq,'montage');title('alignedNcc and HistEq');

figure;imshowpair(rgbAlignedNcc,rgbAlignedSsd,'montage');title('alignedNcc and AlignedSsd');
figure;imshow(gammaCorrection);title('Gamma Correction');
figure;imshow(histEq);title('histEq');

% TO BE DONE: Align the channels
% Functions that might be useful to you for aligning the images include: 
% "circshift", "sum", and "imresize" (for multiscale)
%%%%%aG = align(G,B);
%%%%%aR = align(R,B);
% TO BE DONE: Improve the quality of the aligned image
%circshift(R, 200);
%figure; imshow(rgbNotAligned);
% Save the result using imwrite function
