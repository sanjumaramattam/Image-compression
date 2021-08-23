%Image Compression using DST
clear all
close all

I=imread('peppers_gray.bmp');

% Original Image
subplot(221)
imshow(I)
title('Original Image')
dim=size(I)
N=dim(1)
dst=zeros(dim)

%Discrete Sine Transform Matrix Kernel Computation
for k=1:N
    for n=1:N
        dst(k,n)=sqrt(2/(N+1))*sin(pi/(N+1)*k*n);
    end
end
%Disrete Sine Transform Computation
f=dst*double(I)*dst
%f=f*dst
subplot(222)
imshow(uint8(f),[])
title('DST of image')

% Window  for DST coefficients selection
w=512/3.2
m=[ones(w,w),zeros(w,512-w);zeros(512-w,512)];
subplot(223)
imshow(m)
title('DST Mask')

% DST coefficients selection
f_t=f.*m;

%Image reconstruction with lesser DST Coefficients
r_i=dst*f_t*dst

subplot(224)
imshow(uint8(r_i))
title('Reconstructed image with lesser coefficients')

psnr1=psnr(uint8(r_i),I)