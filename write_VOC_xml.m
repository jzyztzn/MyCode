%% test xml_write() function to write xxx.xml(VOC2007)
% first created by tzn at 20170629

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
for i = 1:1:3
	annotation.object{i}.name = 'person';
	annotation.object{i}.pose = 'Unspecified';
	annotation.object{i}.truncated = '0';
	annotation.object{i}.difficult = '0';
	annotation.object{i}.bndbox.xmin = 45;
	annotation.object{i}.bndbox.ymin = 415;
	annotation.object{i}.bndbox.xmax = 75;
	annotation.object{i}.bndbox.ymax= 450;
end

Pref=[]; Pref.CellItem = false;
xml_write('test.xml', annotation, 'annotation',Pref);
type('test.xml')
