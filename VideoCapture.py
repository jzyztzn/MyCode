# -*- coding: utf-8 -*-
# http://blog.csdn.net/u010167269/article/details/53268686
# tzn 20170623 capture frame then save it from a video(or many videos)
import cv2
import os

# paramater 
# what kind of videos need to search
videos_search_suffix = 'mpg'

# save one frame every () frame
frame_interval_number = 1

#search path and save path
video_search_path = '../'
video_save_path = '../picture'
videos = os.listdir(video_search_path)
videos = filter(lambda x:x.endswith(videos_search_suffix), videos)
# cat videos List
print videos

# read and save frame of videos
for video in videos:
    print video
    video_name, video_suffix = video.split('.')

    # os.mkdir(video_save_path + "/" + video_name)		#可以进行优化，现在只能运行一次

    video_search_full_path = os.path.join(video_search_path, video)
    video_save_full_name = os.path.join(video_save_path, video_name) + '/'

    if not os.path.exists(video_save_full_name):
    	os.mkdir(video_save_full_name)

    cap = cv2.VideoCapture(video_search_full_path)
    frame_count = 1
    success = True
    while(success):			# no do-while() in python
        success, frame = cap.read()
        print "Read a new frame: ", video_name, frame_count, success
        if success != True:
            break
        if frame_count % frame_interval_number == 0:
        	cv2.imwrite(video_save_full_name + video_name + "%d" % frame_count + ".jpg", frame)
        
        frame_count += 1
        
cap.release()