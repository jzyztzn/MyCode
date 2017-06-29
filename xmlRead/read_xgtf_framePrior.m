%% test xml_read() function to read xxx.xgtf
% first created by tzn at 20170629
clear all;clc;
tree = xml_read('Copy_of_actions1.xgtf');
data = tree.data;
sourcefile = data.sourcefile;
object = sourcefile.object;
file = sourcefile.file

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
    if(strcmp(file.attribute(cnt_file).ATTRIBUTE.name,'NUMFRAMES')
        frame_total = file.attribute(cnt_file).data_COLON_dvalue.ATTRIBUTE.value;
    end
end
[object_length, object_length_temp] = size(object);
for cnt_object = 1:1:object_length
    object_name = object(cnt_object).ATTRIBUTE.name
    object_id = object(cnt_object).ATTRIBUTE.id
    if(strcmp(object_name,'PERSON'))
        object_attritube = object(cnt_object).attribute;
        [object_attritube_length, object_attritube_length_temp] = size(object_attritube);
        for cnt_object_attribute = 1:1:object_attritube_length
            if(strcmp(object_attritube(cnt_object_attribute).ATTRIBUTE.name,'Location'))

                data_COLON_bbox = object_attritube(cnt_object_attribute).data_COLON_bbox;
                [data_length,data_length_temp] = size(data_COLON_bbox);
                for num = 1:1:data_length
                    data_COLON_BBOX_attribute = data_COLON_bbox(num).ATTRIBUTE;
                    
                    frame_range = data_COLON_BBOX_attribute.framespan;
                    frame_range_temp = regexp(frame_range,':','split');
                    frame_min = str2num(char(frame_range_temp(1)));
                    frame_max = str2num(char(frame_range_temp(2)));
                    for i = frame_min:1:frame_max
                        frame_num = i;
                        frame_height  = data_COLON_BBOX_attribute.height;
                        frame_width = data_COLON_BBOX_attribute.width;
                        frame_x_min = data_COLON_BBOX_attribute.x;
                        frame_y_min = data_COLON_BBOX_attribute.y;
                        
                        x_min = frame_x_min;
                        y_min = frame_y_min;
                        x_max = frame_x_min + frame_width;
                        y_max = frame_y_min + frame_height;
                        fprintf('-----------------------------------\n');
                        fprintf('frame = %d\n',i);
            %             fprintf('dot_min = (%d, %d) \n',x_min,y_min);
            %             fprintf('dot_max = (%d, %d) \n',x_max,y_max);
                    end

                end

            end
        end
    end
end

