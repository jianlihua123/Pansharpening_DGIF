function F = DGIF (MS,PAN)

%% downsample MS image and Pan image

DMS=imresize(MS,1/4,'bicubic');
DPan=imresize(PAN,1/4,'bicubic');
UMS=imresize(DMS,4,'bicubic');


%% norm all bands be in range 0 to 1.

for i = 1:size(UMS,3)
    bandCoeffs(i) = max(max(UMS(:,:,i)));
    UMS(:,:,i) = UMS(:,:,i)/bandCoeffs(i);
end
panCoeff = max(max(DPan));
Pan = DPan/panCoeff;

%% parameter setup
w = 3;
s1 = 3.4;
s2 = 0.12;

%%  Estimating the Primitive Detail Map

for i = 1:size(UMS,3)
    MS_low(:,:,i) = bfilter2(UMS(:,:,i),w,[s1 s2]);
    MS_high(:,:,i) = UMS(:,:,i)-MS_low(:,:,i);
end


Pan_low = bfilter2(Pan,w,[s1 s2]);
Pan_high = Pan - Pan_low;


F = AIHSMGFfused(UMS,MS_high ,Pan_high ,bandCoeffs);   % main

end

