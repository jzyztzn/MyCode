
Original_path = './original/';
Save_path = './generate/'
files = dir(strcat(Original_path,'*.xml'));
len_files = length(files);
files(1).name
for i = 1:1:len_files

    i
    Old_annotation = xml_read([Original_path,files(i).name]);
%     object = Old_annotation.object;
%     object.name = 'daiji';
%     xml_write('test.xml',Old_annotation);
%     type('test.xml');
    
    
    annotation = [];
    annotation.folder = 'VOC2017_Semaphore';
    % annotation_xml_name = [actions_name,'_',num2str(cnt_frame_total,'%06d')];
    % annotation_image_name = [actions_name,'_',num2str(cnt_frame_total,'%06d')];
    % annotation_full_name = [annotation_image_name,'.jpg'];
    annotation.filename = [Old_annotation.filename,'.jpg'];
    [Old_annotation.filename,'.jpg']
    annotation.source.database = 'The VOC2007 Database';
    annotation.source.annotation = 'PASCAL VOC2007';
    annotation.source.image = 'Unspecified';
    annotation.source.flickrid = 'Unspecified';
    
    annotation.owner.flickrid = 'Unspecified';
    annotation.owner.name = 'Unspecified';
    
    annotation.size.width = Old_annotation.size.width;
    annotation.size.height = Old_annotation.size.height;
    annotation.size.depth = Old_annotation.size.depth;
    
    annotation.segmented = '0';
    
    annotation.object.name = 'lettermark';
    annotation.object.pose = 'Unspecified';
    annotation.object.truncated = '0';
    annotation.object.difficult = '0';
    annotation.object.bndbox.xmin = Old_annotation.object.bndbox.xmin;
    annotation.object.bndbox.ymin = Old_annotation.object.bndbox.ymin;
    annotation.object.bndbox.xmax = Old_annotation.object.bndbox.xmax;
    annotation.object.bndbox.ymax = Old_annotation.object.bndbox.ymax;
    
    xml_write([Save_path,files(i).name],annotation);
end

