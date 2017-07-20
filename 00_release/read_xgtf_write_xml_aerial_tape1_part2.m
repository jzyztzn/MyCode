%% read xgtf

tree = xml_read('tape1_part2.xgtf');

%% data process
actions_name = 'aerial_tape1_part2';
data = tree.data;
sourcefile = data.sourcefile;
object = sourcefile.object;
file = sourcefile.file;

% structure
%{
tree 
----config

----data
--------sourcefile
----------------file
----------------object[:]
--------------------ATTRIBUTE
---------------------------framespan 'xxxx:xxxx'        char     (or 'xxx:xxxx yyy:yyyy'')
---------------------------id:                          double
---------------------------
--------------------attribute[:]
--------------------------attribute(1)
----------------------------------data_COLON_svalue
----------------------------------------ATTRITUBE
-----------------------------------------------value: 'man','car',```
--------------------------attribute(2)
----------------------------------data_COLON_bbox[:]
----------------------------------------ATTRITUBE
-----------------------------------------------framespan     char
-----------------------------------------------height        double
-----------------------------------------------width         double
-----------------------------------------------x             double
-----------------------------------------------y             double






data = tree.data
sourcefile = data.sourcefile
object = sourcefile.object
man_ATTRIBUTE = object(3).ATTRIBUTE.framespan
class = object(3).attribute(1).data_COLON_svalue.ATTRIBUTE.value
% for i = 1:110
%     bndbox_name = object(i).attribute(3).ATTRIBUTE.name,i;
% end
bndbox = object(3).attribute(2).data_COLON_bbox(7).ATTRIBUTE
%}
%% tzn 20170717
[file_length, file_length_temp] = size(file.attribute);
for cnt_file = 1:1:file_length
    if(strcmp(file.attribute(cnt_file).ATTRIBUTE.name,'NUMFRAMES'))
        frame_total = file.attribute(cnt_file).data_COLON_dvalue.ATTRIBUTE.value;
    end
end
% object numbers
[object_length, object_length_temp] = size(object);
% for i = 1:23
%     object(1).attribute(i).ATTRIBUTE.name;
%    
% end



% Operate by frame number
for cnt_frame_total = 12160:1:frame_total          % 第几�?

    %% test xml_write() function to write xxx.xml(VOC2007)
    % first created by tzn at 20170629

    annotation = [];
    annotation.folder = 'VOC2017_2';
    annotation_xml_name = [actions_name,'_',num2str(cnt_frame_total,'%06d')];
    annotation_image_name = [actions_name,'_',num2str(cnt_frame_total,'%06d')];
    annotation_full_name = [annotation_image_name,'.jpg'];
    annotation.filename = annotation_full_name;

    annotation.source.database = 'The VOC2007 Database';
    annotation.source.annotation = 'PASCAL VOC2007';
    annotation.source.image = 'Unspecified';
    annotation.source.flickrid = 'Unspecified';

    annotation.owner.flickrid = 'Unspecified';
    annotation.owner.name = 'Unspecified';

    annotation.size.width = 720;
    annotation.size.height = 480;
    annotation.size.depth = 3;

    annotation.segmented = '0';


    cnt_total_eachframe = 0;
    cnt_vehicle_eachframe = 0;
    cnt_person_eachframe = 0;
    for cnt_object = 1:1:object_length                 % object 
        object_name = object(cnt_object).attribute(1).data_COLON_svalue.ATTRIBUTE.value;    % tzn
        object_id = object(cnt_object).ATTRIBUTE.id;
        if(strcmp(object_name,'man'))            % class
            person_attritube = object(cnt_object).attribute;    % 
            [person_attritube_length, person_attritube_length_temp] = size(person_attritube);
            for cnt_person_attribute = 1:1:person_attritube_length 
                if(strcmp(person_attritube(cnt_person_attribute).ATTRIBUTE.name,'bounding_box'))    % 如果是�?位置信息”就继续

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
%                                 x_min_o = ceil(7*x_min_i/8.0 + x_max_i/8.0);
%                                 y_min_o = ceil(7*y_min_i/8.0 + y_max_i/8.0);
%                                 x_max_o = floor(x_min_i/8.0 + 7*x_max_i/8.0);
%                                 y_max_o = floor(y_min_i/8.0 + 7*y_max_i/8.0);
                                % output bndbox size (the original bndbox size is suitable)
                                x_min_o = x_min_i;
                                y_min_o = y_min_i;
                                x_max_o = x_max_i;
                                y_max_o = y_max_i;                                
                                % check the bndbox information
                                if x_min_o <= 0
                                    break
                                else
                                    x_min_final = x_min_o;
                                end
                                %x_max
                                if x_max_o >  720
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
                                if y_max_o > 480
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

        end
    end
    if(cnt_total_eachframe > 0)
            Pref=[]; Pref.CellItem = false;
            xml_write(['./',actions_name,'/',annotation_xml_name,'.xml'], annotation, 'annotation',Pref);
    end

    % type('test.xml')

end


% data = tree.data
% sourcefile = data.sourcefile
% object = sourcefile.object
% man_ATTRIBUTE = object(3).ATTRIBUTE.framespan
% class = object(3).attribute(1).data_COLON_svalue.ATTRIBUTE.value
% % for i = 1:110
% %     bndbox_name = object(i).attribute(3).ATTRIBUTE.name,i;
% % end
% bndbox = object(3).attribute(2).data_COLON_bbox(7).ATTRIBUTE
