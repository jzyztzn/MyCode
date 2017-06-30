import os
import cv2

video_cap = cv2.VideoCapture('actions1.mpg')

frame_count = 0
all_frames = []
while(True):
    ret, frame = video_cap.read()
    if ret is False:
        break
    all_frames.append(frame)
    frame_count = frame_count + 1

# The value below are both the number of frames
print frame_count
print len(all_frames)