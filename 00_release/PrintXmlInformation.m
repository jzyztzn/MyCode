%% tzn 20170720

clear all;close all;clc;
fprintf('------------------------begin------------------------------')
PATH ='.\xml\';
Files = dir(strcat(PATH,'*.xml'));
lengthFiles = length(Files);
    fid = fopen('CellBBoxInformation.txt','w');
for i = 1:lengthFiles

    annotation = xml_read(strcat(PATH,Files(i).name));
    object = annotation.object;
    [object_length, object_length_temp] = size(object);
    for j = 1:object_length
        name = Files(i).name;
        class = object(j).name;
        xmin = object(j).bndbox.xmin;
        xmax = object(j).bndbox.xmax;
        ymin = object(j).bndbox.ymin;
        ymax = object(j).bndbox.ymax;

    %     fid = fopen('test.txt','w');
        fprintf(fid,'%s\t\t%s\t\t%d\t%d\t%d  %d\t\n',name,class,xmin,ymin,xmax,ymax);
    %     fclose(fid);
    end
    fprintf(fid,'\n');
    
    
    

end
    fclose(fid);
    fprintf('-------------------------end-------------------------------')