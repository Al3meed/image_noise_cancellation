clear ;
clc ;
close all ;

%image import . 
img= imread('Moon.tif') ;
img=rgb2gray(img) ;
%img = imresize(img,[621 400]) ;
figure(1),imshow(img);
title('Original Image', 'FontSize', 14) ; 

%Fourier Transform
FT=fftshift(fft2(img)) ;

figure(2); imshow(log(1+abs(FT)),[]);
title('Original Fourier Spectrum', 'FontSize', 14) ;

%choosing dots from the frequency 
[x0,y0] = getpts();

[r ,c]=size(FT);

%Filter apply

for i=1:r
    for j=1:c
        for n=1:length(x0)
            x=x0(n);
            y=y0(n); 
            if (((x-j)^2)+((y-i)^2)<120) % 120 is the radius
                FT(i,j)=0;
            end
        end
    end
end

% image restoration from the frequency 
figure(3)
S2=log(1+abs(FT)) ; imshow(S2,[]);
title('Filtered Fourier Spectrom', 'FontSize', 14); 
figure(4)
Y=real(ifft2(ifftshift(FT)));
imshow(Y,[]);
title('Filtered Image', 'FontSize', 14); 