# -*- coding: utf-8 -*-
import os
path2Image = 'E:\UcfAnnotation\detection\picture\step3'
Images = os.listdir(path2Image) 
# prefix = 'G18_'
for Image in Images:
    filename, file_extension = os.path.splitext(Image)
    # print file_extension
    if file_extension == '.jpg':
        # print Image
    # print Image
        OldName = Image
        OldDir = os.path.join(path2Image,OldName)
        NewName = prefix + OldName
        NewDir = os.path.join(path2Image,NewName)
        os.rename(OldDir, NewDir)