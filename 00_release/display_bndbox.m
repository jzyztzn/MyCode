%% test xml_read() function to read xxx.xml
% first created by tzn at 20170708
clear all;clc;
image_number = 100;
xml_number = 100;
actions_number = 1;
actions_name = ['actions',num2str(actions_number)];
annotation = xml_read(['C:\temp\create_XmlFiles\',actions_name,'\',actions_name,'_',num2str(xml_number,'%06d'),'.xml']);
% read test.image
I = imread(['C:\temp\picture\',actions_name,'\',actions_name,'_',num2str(image_number,'%06d'),'.jpg']);
size(I)
% dispaly bndbox
object = annotation.object;
[cnt_max,cnt_max_temp] =size(object);
for cnt = 1:1:cnt_max
   
    bndbox = object(cnt).bndbox;
    x_min_i = bndbox.xmin;
    y_min_i = bndbox.ymin;
    x_max_i = bndbox.xmax;
    y_max_i = bndbox.ymax;
    H_i = y_max_i - y_min_i
    
    x_min_o = ceil(7*x_min_i/8.0 + x_max_i/8.0);
    y_min_o = ceil(15*y_min_i/16.0 + y_max_i/16.0);
    x_max_o = floor(x_min_i/8.0 + 7*x_max_i/8.0);
    y_max_o = floor(y_min_i/16.0 + 15*y_max_i/16.0);
    
%     x_min_o = ceil(7*x_min_i/8.0 + x_max_i/8.0);
%     y_min_o = ceil(7*y_min_i/8.0 + y_max_i/8.0);
%     x_max_o = floor(x_min_i/8.0 + 7*x_max_i/8.0);
%     y_max_o = floor(y_min_i/8.0 + 7*y_max_i/8.0);
    
    x_min = x_min_i;
    x_max = x_max_i;
    y_min = y_min_i;
    y_max = y_max_i;
    
    % test the change 
%     I([y_min_i,y_max_i],x_min_i:x_max_i,:) = 255;
%     I(y_min_i:y_max_i,[x_min_i,x_max_i],:) = 255;
%     
%     I([y_min_o,y_max_o],x_min_o:x_max_o,:) = 255;
%     I(y_min_o:y_max_o,[x_min_o,x_max_o],:) = 255;
    
    % test the final bndbox
    I([y_min,y_max],x_min:x_max,:) = 255;
    I(y_min:y_max,[x_min,x_max],:) = 255;
end
imshow(I)
size(I)
imwrite(I,'1.jpg')
