%DWT Based Robust Spread Spectrum Watermarking

[filename1, pathname1]=uigetfile('*.*', 'Select the Cover Image');

coverimage=imread(num2str(filename1));
CI=coverimage; %uint8 image
coverimage=double(coverimage);
[filename2, pathname2]=uigetfile('*.*', 'Select the Watermark Image'); 
watermark=imread(num2str(filename2));
WMO=watermark; %binary water mrk


N=1; %Decomposition Levels
L=2^N; %Dimension reduction by L at level N
wavetype='bior6.8'; %Wavelet Type

K=0.05; %Embedding Strength


%Determine size of cover image
[Mc, Nc]=size(coverimage);

%Determine the size of watermark
[Mwmo,Nwmo]=size(watermark);
wmvector=reshape(watermark,Mwmo*Nwmo,1);

%-------------Watermark Embedding------------------

key=1000; %Initialize Key
rng(key); %Reset PN generator to state "key"
pnsequence=round(2*(rand(Mc/L, Nc/L)-0.5)); %Generate PRN Sequence

dwtmode ('per') %Setting Wavelet Decomposition Mode
[C1, S1]= wavedec2 (coverimage, N, wavetype); %DWT of Image
cA1=appcoef2(C1, S1, wavetype,N);
[cH1, cV1, cD1]=detcoef2('all',C1,S1,N);

%Adding PRN sequences to CD1 components when watermark bit = 0
for i=1:length(wmvector)
     if wmvector(i)== 0
       cD1=cD1+K*pnsequence;
     end
pnsequence=round(2*(rand(Mc/L,Nc/L)-0.5));
end

x=size(cA1,1); y=size(cA1,2);
cA1row=reshape(cA1,1,x*y); cH1row=reshape(cH1,1,x*y);
cV1row=reshape(cV1,1,x*y); cD1row=reshape(cD1,1,x*y);
cc=[cA1row,cH1row,cV1row,cD1row];
ccl=length(cc); C1(1:ccl)=cc;

watermarked_image=waverec2(C1,S1,wavetype); %IDWT
watermarked_image_uint8=uint8(watermarked_image);

watermarked_image_uint8=imnoise(watermarked_image_uint8,'salt & pepper',0.02);

imwrite(watermarked_image_uint8,'dwt_watermarked.jpg','quality',100);

%Calculate PSNR
mse = sum(sum((watermarked_image-coverimage).^2 ))/(Mc*Nc);
maxp = max(max(watermarked_image(:)), max(coverimage (:)));
PSNR = 10*log10((maxp^2)/mse);
fprintf('\nPSNR = %f\n',PSNR);

%Display Original and Watermarked image
figure(1)
subplot(121)
imshow(CI); title('Original Image')
subplot (122)
imshow(watermarked_image_uint8); title('Watermarked Image')


%------------------------Watermark Recovery---------------------

file_name='dwt_watermarked.jpg';
watermarked_image=double(imread(file_name)); %Reading watermarked image 
[Mw,Nw]=size(watermarked_image); %Determine size of watermarked image
wmvectorr=ones(1,Mwmo*Nwmo); %Initialize watermark to all bits=1

[C2,S2]= wavedec2(watermarked_image,N,wavetype); %DWT
cD2=detcoef2('d',C2,S2,N);

key=1000;
rng(key); %Reset PN generator to state "key"

pnsequence=round(2*(rand(Mw/L,Nw/L)-0.5)); %Generate PRN Sequence

%Add PRN sequences to CDs coeffs. when watermark bit= 0
for i=1:length(wmvectorr)
     correlation(i)=corr2(cD2,pnsequence);
     pnsequence=round(2*(rand(Mw/L,Nw/L)-0.5));
end

T=mean(correlation); %T=T; %Finding Threshold for WM recovery
Tvec=T*ones(1,length(correlation));
figure(2); plot(correlation); hold on; plot (Tvec);
title('Correlation Pattern'); hold off;

for i=1:length (wmvectorr)
     if correlation(i)>T %Comparing correlation with Threshold
        wmvectorr(i)=0;
     end
end

WMR=reshape(wmvectorr,Mwmo,Nwmo); %Recovered Watermark

figure (3)
subplot (121)
imshow(WMO); title('Original Watermark')
subplot (122)
imshow(WMR); title('Recovered Watermark')
imwrite(uint8(WMR), 'recovered_watermarkNoise.jpg');








