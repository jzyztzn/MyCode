function [out] = Xgtf2VOCXml( input_xgtf_filename )

%% test xml_read() function to read xxx.xgtf
% first created by tzn at 20170629
clear all;clc;

if ischar(input_xgtf_filename)
    input_xgtf_filename = xmlstringinput(input_xgtf_filename,true);
end
input_xgtf_filename
[xgtf_path,xgtf_filename,xgtf_suffix] = fileparts(input_xgtf_filename);
tree = xml_read([xgtf_filename,xgtf_suffix]);
data = tree.data;
sourcefile = data.sourcefile;
object = sourcefile.object;
file = sourcefile.file;

% struct
%{
tree 
----config
----data
--------sourcefile
----------------file
----------------object[:]
--------------------ATTRIBUTE
---------------------------framespan 'xxxx:xxxx'        char
---------------------------id:                          double
---------------------------name: 'PERSON','VEHICLE'     char
--------------------attribute[:]
---------------------------ATTRIBUTE
-----------------------------------name: 'Location','Occlusion', '...'  char
---------------------------data_COLON_bbox[:]
-----------------------------------context
-----------------------------------attribute
------------------------------------------framespan     char
------------------------------------------height        double
------------------------------------------width         double
------------------------------------------x             double
------------------------------------------y             double
---------------------------data_COLON_bvalue
---------------------------data_COLON_fvalue

%}
[file_length, file_length_temp] = size(file.attribute);
for cnt_file = 1:1:file_length
    if(strcmp(file.attribute(cnt_file).ATTRIBUTE.name,'NUMFRAMES'))
        frame_total = file.attribute(cnt_file).data_COLON_dvalue.ATTRIBUTE.value;
    end
end
% object numbers
[object_length, object_length_temp] = size(object);

% Operate by frame number
for cnt_frame_total = 1:1:5 %frame_total          % ?????????

    %% test xml_write() function to write xxx.xml(VOC2007)
    % first created by tzn at 20170629

    annotation = [];
    annotation.folder = 'VOC2017';
    annotation_xml_name = ['xgtf_filename','_',num2str(cnt_frame_total,'%06d')];
    annotation_full_name = [annotation_xml_name,'.jpg'];
    annotation.filename = annotation_full_name;

    annotation.source.database = 'The VOC2007 Database';
    annotation.source.annotation = 'PASCAL VOC2007';
    annotation.source.image = 'Unspecified';
    annotation.source.flickrid = 'Unspecified';

    annotation.owner.flickrid = 'Unspecified';
    annotation.owner.name = 'Unspecified';

    annotation.size.width = 960;
    annotation.size.height = 540;
    annotation.size.depth = 3;

    annotation.segmented = '0';


    cnt_person_eachframe = 1;              % ?��???��?��?��?��??-????oo??��
    for cnt_object = 1:1:object_length                 % object ?????�㨦??
        object_name = object(cnt_object).ATTRIBUTE.name;
        object_id = object(cnt_object).ATTRIBUTE.id;
        if(strcmp(object_name,'PERSON'))            % ?|??????��a??ooa??���??��???
            object_attritube = object(cnt_object).attribute;    % ������object????��?????a???
            [object_attritube_length, object_attritube_length_temp] = size(object_attritube);
            for cnt_object_attribute = 1:1:object_attritube_length 
                if(strcmp(object_attritube(cnt_object_attribute).ATTRIBUTE.name,'Location'))    % ?|??????��a????????????��a??���??��??-

                    data_COLON_bbox = object_attritube(cnt_object_attribute).data_COLON_bbox;
                    [data_length,data_length_temp] = size(data_COLON_bbox);                     
 
                    for num = 1:1:data_length           % ������object?????��??��??��??�㨦??
                        data_COLON_BBOX_attribute = data_COLON_bbox(num).ATTRIBUTE;
                        
                        frame_range = data_COLON_BBOX_attribute.framespan;
                        frame_range_temp = regexp(frame_range,':','split');
                        frame_min = str2num(char(frame_range_temp(1)));
                        frame_max = str2num(char(frame_range_temp(2)));

                        

                        for cnt_frame = frame_min:1:frame_max                           %������??��??��??��????����??��??��??��????��??????xxx --> xxx)

                            if(cnt_frame == cnt_frame_total)

                                frame_num = cnt_frame;
                                frame_height  = data_COLON_BBOX_attribute.height;
                                frame_width = data_COLON_BBOX_attribute.width;
                                frame_x_min = data_COLON_BBOX_attribute.x;
                                frame_y_min = data_COLON_BBOX_attribute.y;
                                
                                x_min = frame_x_min;
                                y_min = frame_y_min;
                                x_max = frame_x_min + frame_width;
                                y_max = frame_y_min + frame_height;
                                
                                fprintf('frame = %d\n',cnt_frame);
                                fprintf('dot_min = (%d, %d) \n',x_min,y_min);
                                fprintf('dot_max = (%d, %d) \n',x_max,y_max);
                                fprintf('-----------------------------------\n');
                                bonbox_xmin = x_min;
                                bonbox_ymin = y_min;
                                bonbox_xmax = x_max;
                                bonbox_ymax = y_max;

                                
                                annotation.object{cnt_person_eachframe}.name = 'person';
                                annotation.object{cnt_person_eachframe}.pose = 'Unspecified';
                                annotation.object{cnt_person_eachframe}.truncated = '0';
                                annotation.object{cnt_person_eachframe}.difficult = '0';
                                annotation.object{cnt_person_eachframe}.bndbox.xmin = bonbox_xmin;
                                annotation.object{cnt_person_eachframe}.bndbox.ymin = bonbox_ymin;
                                annotation.object{cnt_person_eachframe}.bndbox.xmax = bonbox_xmax;
                                annotation.object{cnt_person_eachframe}.bndbox.ymax = bonbox_ymax;
                                
                                cnt_person_eachframe = cnt_person_eachframe + 1;


                            end

                        end



                    end


                end
            end
        end
    end

    Pref=[]; Pref.CellItem = false;
    xml_write(['./',xgtf_filename,'/',annotation_xml_name,'.xml'], annotation, 'annotation',Pref);
    % type('test.xml')

end




end

