%------------------------Watermark Recovery---------------------

file_name='noisy_imageBaboon.png';
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

