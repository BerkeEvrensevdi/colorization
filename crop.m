function croppedimg = crop(img)


targetSize = [295,345];
r = centerCropWindow2d(size(img),targetSize);
croppedimg = imcrop(img,r);
