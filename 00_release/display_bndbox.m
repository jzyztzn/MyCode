%% test xml_read() function to read xxx.xml

% first created by tzn at 20170708

clear all;close all;clc;
i_min = 9200;
ImageReadPath = 'C:\temp\picture\';%aerial_tape3_part1\';
XmlReadPath = 'E:\UcfAnnotation\123\create_XmlFiles\';
actions_name = 'aerial_tape1_part1';
for i = i_min:1:i_min + 20
    
    image_number = i;
    xml_number = image_number;%300;
    actions_number = 2;
    % actions_name = ['actions',num2str(actions_number)];
    xmlfile_name = [XmlReadPath, actions_name,'\',actions_name,'_',num2str(xml_number,'%06d'),'.xml'];
    if ~exist(xmlfile_name,'file')==0
        annotation = xml_read(xmlfile_name);
        % read test.image
        % I = imread(['C:\temp\picture\',actions_name,'\',actions_name,'_',num2str(image_number,'%06d'),'.jpg']);
        I = imread([ImageReadPath,actions_name,'\',actions_name,'_',num2str(image_number,'%06d'),'.jpg']);
        size(I);
        % dispaly bndbox
%         xmlfile_name;
        object = annotation.object;
        [cnt_max,cnt_max_temp] =size(object);
        for cnt = 1:1:cnt_max

            bndbox = object(cnt).bndbox;
            x_min_i = bndbox.xmin;
            y_min_i = bndbox.ymin;
            x_max_i = bndbox.xmax;
            y_max_i = bndbox.ymax;
    %         H_i = y_max_i - y_min_i
    % 
    %         x_min_o = ceil(7*x_min_i/8.0 + x_max_i/8.0);
    %         y_min_o = ceil(15*y_min_i/16.0 + y_max_i/16.0);
    %         x_max_o = floor(x_min_i/8.0 + 7*x_max_i/8.0);
    %         y_max_o = floor(y_min_i/16.0 + 15*y_max_i/16.0);

        %     x_min_o = ceil(7*x_min_i/8.0 + x_max_i/8.0);
        %     y_min_o = ceil(7*y_min_i/8.0 + y_max_i/8.0);
        %     x_max_o = floor(x_min_i/8.0 + 7*x_max_i/8.0);
        %     y_max_o = floor(y_min_i/8.0 + 7*y_max_i/8.0);
        
            x_min_o = ceil(3*x_min_i/4.0 + x_max_i/4.0);
            y_min_o = ceil(3*y_min_i/4.0 + y_max_i/4.0);
            x_max_o = floor(x_min_i/4.0 + 3*x_max_i/4.0);
            y_max_o = floor(y_min_i/4.0 + 3*y_max_i/4.0);
            % x_min
    %         if x_min_i <= 0
    %             break
    %         else
    %             x_min = x_min_i;
    %         end
    %         %x_max
    %         if x_max_i >= 960
    %             break;
    %         else
    %             x_max = x_max_i;
    %         end
    %         % y_min
    %         if y_min_i <= 0
    %             break;
    %         else
    %             y_min = y_min_i;
    %         end
    %         %y_max
    %         if y_max_i >= 540
    %             break
    %         else
    %             y_max = y_max_i;
    %         end
            x_min = x_min_i;
            x_max = x_max_i;
            y_min = y_min_i;
            y_max = y_max_i;
            
%             x_min = x_min_o;
%             x_max = x_max_o;
%             y_min = y_min_o;
%             y_max = y_max_o;

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
        figure
        imshow(I)
        size(I);
    %     imwrite(I,'1.jpg')

    end

end