# -*- coding: ucf8 -*-
import os
# created by tzn at 20170712
# rename all the names of semaphore images

path = "./dataQY"
ActionClasses = os.listdir(path)
# ActionClasses = ["asdd"]
for ActionClass in ActionClasses:
    path2Person = path+"/"+ActionClass
    PersonNames = os.listdir(path2Person) 
    for PersonName in PersonNames:
        i = 1       
        path2Direction = path2Person + "/" + PersonName
        Directions = os.listdir(path2Direction)
        for Direction in Directions:
            path2Image = path2Direction + "/" + Direction
            Images = os.listdir(path2Image)            
            for Image in Images:
                OldName = Image
                OldDir = os.path.join(path2Image,OldName)
                NewName = ActionClass + "_" + PersonName + "_" + Direction + "_" + str("%06d" % i) + ".jpg"
                NewDir = os.path.join(path2Image,NewName)
                os.rename(OldDir, NewDir)
                i += 1


            

