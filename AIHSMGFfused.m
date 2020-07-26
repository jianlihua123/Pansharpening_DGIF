function F = AIHSMGFfused(UMS,UMS_h,Pan_high,bandCoeffs)


%% obtain I component
findalph = AIHS(UMS_h,Pan_high);%find the best alph weights
I = findalph(1)*UMS_h(:,:,1) + findalph(2)*UMS_h(:,:,2) + findalph(3)*UMS_h(:,:,3) + findalph(4)*UMS_h(:,:,4);

%% obtain details by Guide Filter repeatedly
detail = getdetail( I,Pan_high );

%% obtain the final fused image
[m,n,d] = size(UMS);

for i = 1:d
    
    F(:,:,i) = (UMS(:,:,i) + detail)*bandCoeffs(i);
    
end