% test xml_read() function to read xxx.xml
% first created by tzn at 20170628
tree = xml_read('actions1.xgtf');
data_COLON_bbox = tree.data_COLON_bbox;
[data_length,data_length_temp] = size(data_COLON_bbox)
for num = 1:1:data_length
    % attribute = data.ATTRIBUTE;
    attribute = tree.data_COLON_bbox(num).ATTRIBUTE;
    
    frame_range = attribute.framespan;
    frame_range_temp = regexp(frame_range,':','split');
    frame_min = str2num(char(frame_range_temp(1)));
    frame_max = str2num(char(frame_range_temp(2)));
    for i = frame_min:1:frame_max
        frame_num = i;
        frame_height  = attribute.height;
        frame_width = attribute.width;
        frame_x_min = attribute.x;
        frame_y_min = attribute.y;
        
        x_min = frame_x_min;
        y_min = frame_y_min;
        x_max = frame_x_min + frame_width;
        y_max = frame_y_min + frame_height;
        fprintf('-----------------------------------');
        fprintf('frame = %d\n',i);
        fprintf('dot_min = (%d, %d) \n',x_min,y_min);
        fprintf('dot_max = (%d, %d) \n',x_max,y_max);
    end
end
