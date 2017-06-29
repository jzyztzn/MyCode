# coding:utf-8

#tzn 20170626 win10 python 2.7
#from xml.etree.ElementTree import Element, SubElement, tostring
from lxml.etree import Element, SubElement, tostring
import pprint
from xml.dom.minidom import parseString
import os

#------------------------------------------------------------------
folder_names = 
image_names = 




x_min = 
y_min = 
bbox_Width = 
bbox_Height = 
x_max = x_min + bbox_Width
y_max = y_min + bbox_Height









#------------------------------------------------------------------
# root
node_root = Element('annotation')

node_folder = SubElement(node_root, 'folder')
node_folder.text = 'actions1'

node_filename = SubElement(node_root, 'filename')
node_filename.text = '000001.jpg'
#------------------------------------------------------------------
# size
node_size = SubElement(node_root, 'size')
node_width = SubElement(node_size, 'width')
node_width.text = '960'

node_height = SubElement(node_size, 'height')
node_height.text = '540'

node_depth = SubElement(node_size, 'depth')
node_depth.text = '3'
#------------------------------------------------------------------
# segmented
node_segmented = SubElement(node_root, 'segmented')
node_segmented.text = '0'
#------------------------------------------------------------------
# object
for i in range(0,2):
	node_object = SubElement(node_root, 'object')

	node_name = SubElement(node_object, 'name')
	node_name.text = 'person'

	# node_pose = SubElement(node_object, 'pose')
	# node_pose.text = 'Unspecified'

	# node_trubcated = SubElement(node_object,'trubcated')
	# node_trubcated.text = '0'

	# node_difficult = SubElement(node_object, 'difficult')
	# node_difficult.text = '0'

	node_bndbox = SubElement(node_object, 'bndbox')
	node_xmin = SubElement(node_bndbox, 'xmin')
	node_xmin.text = '99'
	node_ymin = SubElement(node_bndbox, 'ymin')
	node_ymin.text = '358'
	node_xmax = SubElement(node_bndbox, 'xmax')
	node_xmax.text = '135'
	node_ymax = SubElement(node_bndbox, 'ymax')
	node_ymax.text = '375'

xml = tostring(node_root, pretty_print=True)  #格式化显示，该换行的换行
dom = parseString(xml)
print xml