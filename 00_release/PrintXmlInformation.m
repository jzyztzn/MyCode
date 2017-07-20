%% tzn 20170720

clear all;close all;clc;

PATH ='.\Annotations\';
Files = dir(strcat(PATH,'*.xml'));
lengthFiles = length(Files);
    fid = fopen('test1111.txt','w');
for i = 1:lengthFiles

    annotation = xml_read(strcat(PATH,Files(i).name));
    object = annotation.object;
    
    name = Files(i).name;
    class = object.name;
    xmin = object.bndbox.xmin;
    xmax = object.bndbox.xmax;
    ymin = object.bndbox.ymin;
    ymax = object.bndbox.ymax;
    
%     fid = fopen('test.txt','w');
    fprintf(fid,'%s\t\t%s\t\t%d\t%d\t%d  %d\t\n',name,class,xmin,ymin,xmax,ymax);
%     fclose(fid);
    
    
    
    
    %自己写图像处理函数 ImgProc(Img);
end
    fclose(fid);