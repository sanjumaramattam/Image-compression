clear all
close all
I=imread('peppers_gray.bmp');
subplot(231)
imshow(I)

%Centered DFT Computation
f=fft2(I);
c_f=fftshift(f);
d=abs(c_f);
subplot(234)
imshow(uint16(d),[])
title('Centered Spectrum of image')

% FFT Coefficients threshholding
%h=d>mean(mean(d));
%m=double(h)
%f_t=c_f.*m;

%DFT Mask creation( Low Pass filter)
circ = drawcircle('Center',[256,256],'Radius',60);
m=createMask(circ)
subplot(232)
imshow(m)
title('DCT Mask LPF')

%image reconstruction
f_t=c_f.*m;
r_i=ifft2(ifftshift(f_t));
subplot(235)
imshow(uint8(r_i))
title('Reconstructed image with lesser coefficients(Low pass filtering)')


%DFT Mask creation( High Pass filter)
h_m=ones(512,512)-m
subplot(233)
imshow(h_m)
title('DCT Mask HPF')

%image reconstruction
f_t=c_f.*h_m;
r_i=ifft2(ifftshift(f_t));
subplot(236)
imshow(uint8(r_i))
title('Reconstructed image with finer coefficients(HPF)')