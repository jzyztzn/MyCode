%% tzn 20170727
clear all;close all;clc;
Original_path = './original/';
Save_path = './generate/';
files = dir(strcat(Original_path,'*.xml'));
len_files = length(files);
files(1).name;
fprintf('----------------begin----------------------\n');
for i = 1:1:len_files

    Old_annotation = xml_read([Original_path,files(i).name]);
    object = Old_annotation.object;
    annotation = [];
    annotation.folder = 'VOC2017_Cell';
    annotation.filename = ['G18_',Old_annotation.filename];
    annotation.source.database = 'Unknown';
%     annotation.source.annotation = 'PASCAL VOC2007';
%     annotation.source.image = 'Unspecified';
%     annotation.source.flickrid = 'Unspecified';
    
%     annotation.owner.flickrid = 'Unspecified';
%     annotation.owner.name = 'Unspecified';
    
    annotation.size.width = Old_annotation.size.width;
    annotation.size.height = Old_annotation.size.height;
    annotation.size.depth = Old_annotation.size.depth;
    
    annotation.segmented = '0';
    [object_length, object_lengthtemp] = size(object);
    for cnt = 1:object_length
%         cnt
        annotation.object{cnt}.name = Old_annotation.object(cnt).name;
        annotation.object{cnt}.pose = Old_annotation.object(cnt).pose;
        annotation.object{cnt}.truncated = '0';
        annotation.object{cnt}.difficult = '0';
        annotation.object{cnt}.bndbox.xmin = Old_annotation.object(cnt).bndbox.xmin;
        annotation.object{cnt}.bndbox.ymin = Old_annotation.object(cnt).bndbox.ymin;
        annotation.object{cnt}.bndbox.xmax = Old_annotation.object(cnt).bndbox.xmax;
        annotation.object{cnt}.bndbox.ymax = Old_annotation.object(cnt).bndbox.ymax;
    end
    xml_write([Save_path,'G18_',files(i).name],annotation);
    
end
fprintf('-----------------end-----------------------\n');

