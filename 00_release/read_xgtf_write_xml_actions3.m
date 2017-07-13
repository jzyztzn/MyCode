%% test xml_read() function to read xxx.xgtf
% first created by tzn at 20170629
% changed by tzn at 20170708    xxx.xml --> xxx.jpg
clear all;clc;close all;
actions_name = 'actions3';
tree = xml_read([actions_name,'.xgtf']);
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
for cnt_frame_total = 1:1:frame_total          % 第几�?

    %% test xml_write() function to write xxx.xml(VOC2007)
    % first created by tzn at 20170629

    annotation = [];
    annotation.folder = 'VOC2017';
    annotation_xml_name = [actions_name,'_',num2str(cnt_frame_total-1,'%06d')];
	annotation_image_name = [actions_name,'_',num2str(cnt_frame_total-1,'%06d')];
    annotation_full_name = [annotation_image_name,'.jpg'];
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


    cnt_total_eachframe = 0;
    cnt_vehicle_eachframe = 0;
    cnt_person_eachframe = 0;
    for cnt_object = 2:1:object_length                 % object 的数�?
        object_name = object(cnt_object).ATTRIBUTE.name;
        object_id = object(cnt_object).ATTRIBUTE.id;
        if(strcmp(object_name,'PERSON'))            % 如果是�?人�?就继�?
            person_attritube = object(cnt_object).attribute;    % 该object的属性个�?
            [person_attritube_length, person_attritube_length_temp] = size(person_attritube);
            for cnt_person_attribute = 1:1:person_attritube_length 
                if(strcmp(person_attritube(cnt_person_attribute).ATTRIBUTE.name,'Location'))    % 如果是�?位置信息”就继续

                    person_data_COLON_bbox = person_attritube(cnt_person_attribute).data_COLON_bbox;
                    [person_data_length,person_data_length_temp] = size(person_data_COLON_bbox);                     
 
                    for num = 1:1:person_data_length           % 该object的帧数块数量
                        person_data_COLON_BBOX_attribute = person_data_COLON_bbox(num).ATTRIBUTE;
                        
                        frame_range = person_data_COLON_BBOX_attribute.framespan;
                        frame_range_temp = regexp(frame_range,':','split');
                        frame_min = str2num(char(frame_range_temp(1)));
                        frame_max = str2num(char(frame_range_temp(2)));

                        

                        for cnt_frame = frame_min:1:frame_max                           %该帧数块的具体数值范围（从xxx --> xxx)

                            if(cnt_frame == cnt_frame_total)

                                frame_num = cnt_frame;
                                frame_height  = person_data_COLON_BBOX_attribute.height;
                                frame_width = person_data_COLON_BBOX_attribute.width;
                                frame_x_min = person_data_COLON_BBOX_attribute.x;
                                frame_y_min = person_data_COLON_BBOX_attribute.y;
                                % original bndbox size
                                x_min_i = frame_x_min;
                                y_min_i = frame_y_min;
                                x_max_i = frame_x_min + frame_width;
                                y_max_i = frame_y_min + frame_height;
                                % output bndbox size (the original bndbox size is too big)
                                x_min_o = ceil(7*x_min_i/8.0 + x_max_i/8.0);
                                y_min_o = ceil(7*y_min_i/8.0 + y_max_i/8.0);
                                x_max_o = floor(x_min_i/8.0 + 7*x_max_i/8.0);
                                y_max_o = floor(y_min_i/8.0 + 7*y_max_i/8.0);
                                % check the bndbox information
                                if x_min_o <= 0
                                    break
                                else
                                    x_min_final = x_min_o;
                                end
                                %x_max
                                if x_max_o >  960
                                    break;
                                else
                                    x_max_final = x_max_o;
                                end
                                % y_min
                                if y_min_o <= 0
                                    break;
                                else
                                    y_min_final = y_min_o;
                                end
                                %y_max
                                if y_max_o > 540
                                    break
                                else
                                    y_max_final = y_max_o;
                                end                               
                                
                                %final bndbox size
                                fprintf('frame = %d\n',cnt_frame);
                                fprintf('dot_min = (%d, %d) \n',x_min_final,y_min_final);
                                fprintf('dot_max = (%d, %d) \n',x_max_final,y_max_final);
                                fprintf('-----------------------------------\n');
                                bonbox_xmin = x_min_final;
                                bonbox_ymin = y_min_final;
                                bonbox_xmax = x_max_final;
                                bonbox_ymax = y_max_final;


                                cnt_total_eachframe = cnt_total_eachframe + 1;
                                cnt_person_eachframe = cnt_person_eachframe + 1;
                                
                                annotation.object{cnt_total_eachframe}.name = 'person';
                                annotation.object{cnt_total_eachframe}.pose = 'Unspecified';
                                annotation.object{cnt_total_eachframe}.truncated = '0';
                                annotation.object{cnt_total_eachframe}.difficult = '0';
                                annotation.object{cnt_total_eachframe}.bndbox.xmin = bonbox_xmin;
                                annotation.object{cnt_total_eachframe}.bndbox.ymin = bonbox_ymin;
                                annotation.object{cnt_total_eachframe}.bndbox.xmax = bonbox_xmax;
                                annotation.object{cnt_total_eachframe}.bndbox.ymax = bonbox_ymax;
                                



                            end

                        end



                    end


                end
            end

%         else if(strcmp(object_name,'VCHICLE'))            % vchicle
%             vehicle_attritube = object(cnt_object).attribute;    % 该object的属性个�?
%             [person_attritube_length, person_attritube_length_temp] = size(vehicle_attritube);
%             for cnt_person_attribute = 1:1:person_attritube_length 
%                 if(strcmp(vehicle_attritube(cnt_person_attribute).ATTRIBUTE.name,'Location'))    % 如果是�?位置信息”就继续
% 
%                     person_data_COLON_bbox = vehicle_attritube(cnt_person_attribute).data_COLON_bbox;
%                     [person_data_length,person_data_length_temp] = size(person_data_COLON_bbox);                     
%  
%                     for num = 1:1:person_data_length           % 该object的帧数块数量
%                         person_data_COLON_BBOX_attribute = person_data_COLON_bbox(num).ATTRIBUTE;
%                         
%                         frame_range = person_data_COLON_BBOX_attribute.framespan;
%                         frame_range_temp = regexp(frame_range,':','split');
%                         frame_min = str2num(char(frame_range_temp(1)));
%                         frame_max = str2num(char(frame_range_temp(2)));
% 
%                         
% 
%                         for cnt_frame = frame_min:1:frame_max                           %该帧数块的具体数值范围（从xxx --> xxx)
% 
%                             if(cnt_frame == cnt_frame_total)
% 
%                                 frame_num = cnt_frame;
%                                 frame_height  = person_data_COLON_BBOX_attribute.height;
%                                 frame_width = person_data_COLON_BBOX_attribute.width;
%                                 frame_x_min = person_data_COLON_BBOX_attribute.x;
%                                 frame_y_min = person_data_COLON_BBOX_attribute.y;
%                                 
%                                 x_min = frame_x_min;
%                                 y_min = frame_y_min;
%                                 x_max = frame_x_min + frame_width;
%                                 y_max = frame_y_min + frame_height;
%                                 
%                                 fprintf('frame = %d\n',cnt_frame);
%                                 fprintf('dot_min = (%d, %d) \n',x_min,y_min);
%                                 fprintf('dot_max = (%d, %d) \n',x_max,y_max);
%                                 fprintf('-----------------------------------\n');
%                                 bonbox_xmin = x_min;
%                                 bonbox_ymin = y_min;
%                                 bonbox_xmax = x_max;
%                                 bonbox_ymax = y_max;
% 
%                                 cnt_total_eachframe = cnt_total_eachframe + 1;
%                                 cnt_person_eachframe = cnt_person_eachframe + 1;
%                                 
%                                 annotation.object{cnt_total_eachframe}.name = 'person';
%                                 annotation.object{cnt_total_eachframe}.pose = 'Unspecified';
%                                 annotation.object{cnt_total_eachframe}.truncated = '0';
%                                 annotation.object{cnt_total_eachframe}.difficult = '0';
%                                 annotation.object{cnt_total_eachframe}.bndbox.xmin = bonbox_xmin;
%                                 annotation.object{cnt_total_eachframe}.bndbox.ymin = bonbox_ymin;
%                                 annotation.object{cnt_total_eachframe}.bndbox.xmax = bonbox_xmax;
%                                 annotation.object{cnt_total_eachframe}.bndbox.ymax = bonbox_ymax;
% 
% 
% 
% 
% 
        end
    end
    if(cnt_total_eachframe > 0)
            Pref=[]; Pref.CellItem = false;
            xml_write(['./',actions_name,'/',annotation_xml_name,'.xml'], annotation, 'annotation',Pref);
    end

    % type('test.xml')

end

