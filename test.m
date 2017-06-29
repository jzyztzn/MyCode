% test write prior

% created by tzn at 20170629
% read xgtf file first
clear all;clc;
tree = xml_read('actions1.xgtf');
data = tree.data;
sourcefile = data.sourcefile;
object = sourcefile.object;

%% object size of upon xgtf file
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




						annotation = [];
						annotation.folder = 'VOC2017';
						annotation.filename = '000001.jpg';

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
						% for i = 1:1:3
					    annotation.object{cnt_object}.name = 'person';
					    annotation.object{cnt_object}.pose = 'Unspecified';
					    annotation.object{cnt_object}.truncated = '0';
					    annotation.object{cnt_object}.difficult = '0';
					    annotation.object{cnt_object}.bndbox.xmin = x_min;
					    annotation.object{cnt_object}.bndbox.ymin = y_min;
					    annotation.object{cnt_object}.bndbox.xmax = x_max;
					    annotation.object{cnt_object}.bndbox.ymax = y_max;
						% end





                    end

                end

            end
        end
    end
end






	annotation = [];
	annotation.folder = 'VOC2017';
	annotation.filename = '000001.jpg';

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
	% for i = 1:1:3
    annotation.object{cnt_object}.name = 'person';
    annotation.object{cnt_object}.pose = 'Unspecified';
    annotation.object{cnt_object}.truncated = '0';
    annotation.object{cnt_object}.difficult = '0';
    annotation.object{cnt_object}.bndbox.xmin = 45;
    annotation.object{cnt_object}.bndbox.ymin = 415;
    annotation.object{cnt_object}.bndbox.xmax = 75;
    annotation.object{cnt_object}.bndbox.ymax= 450;
	% end

	Pref=[]; Pref.CellItem = false;

	xml_write('test.xml', annotation, 'annotation',Pref);
	type('test.xml')
