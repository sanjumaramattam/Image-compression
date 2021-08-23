%Image Compression using DCT
clear all
close all

I=imread('peppers_gray.bmp');

% Original Image
subplot(221)
imshow(I)
title('Original Image')

%DCT Computation
f=dct2(I);
subplot(222)
imshow(uint8(abs(f)),[])
title('DCT of image')

% Window  for DCT coefficients selection
w=512/3.2;
m=[ones(w,w),zeros(w,512-w);zeros(512-w,512)];
subplot(223)
imshow(m)
title('DCT Mask')

% DCT coefficients selection
f_t=f.*m;

%Image reconstruction with lesser DCT Coefficients
r_i=idct2(f_t);
subplot(224)
imshow(uint8(r_i))
title('Reconstructed image with lesser coefficients')

snr=psnr(uint8(r_i),I)
si=ssim(uint8(r_i),I)