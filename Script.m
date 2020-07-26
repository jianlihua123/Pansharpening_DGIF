clear;
close all;
clc;

%%%% load source images
file_path1 = './imagepairs/MS/';
file_path2 = './imagepairs/PAN/';
output_path = './results/';
img_path_list = dir(strcat(file_path1, '*.tif'));
img_num = length(img_path_list);

tic;
if img_num > 0
    for j = 1:img_num
        MS_image_name = img_path_list(j).name;
        [filepath,name,ext] = fileparts(MS_image_name);
        index = regexp(name,'\d*\.?\d*','match');
        MS_image =  imread(strcat(file_path1,MS_image_name));
        
        PAN_image_name = strcat('Pan',num2str(index{1}),'.tif');
        PAN_image =  imread(strcat(file_path2,PAN_image_name));
        
        fprintf('%d %d %s\n',i,j,strcat(MS_image_name,'____',PAN_image_name));
        
        OMS = double(MS_image);
        OPan = double(PAN_image);
        
        %%%%%%%%%% fusion %%%%%%%%%%%%%%%%%%%%%%%
        MGF = DGIF(OMS,OPan);
        %%%%%%%%%% display %%%%%%%%%%%%%%%%%%%%%%%
        for i = 1:3
            MGF(:,:,i) = (MGF(:,:,i)-min(min(MGF(:,:,i))))/(max(max(MGF(:,:,i)))-min(min(MGF(:,:,i))));
            MGF(:,:,i) = imadjust(MGF(:,:,i),stretchlim(MGF(:,:,i)),[0.05,0.95]);
        end
        imwrite(MGF(:,:,1:3),strcat(output_path,strcat('F',num2str(index{1}),'.bmp')));
    end
end
toc;



