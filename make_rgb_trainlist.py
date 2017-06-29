#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
i = 0
j = 0
classList = ['JumpingJack', 'PullUps', 'RockClimbingIndoor', 'TaiChi', 'BabyCrawling', 'HandstandPushups']
for classInd in classList #os.listdir('.'):
	i += 1		
	for file in os.listdir(classInd):
		for img in os.listdir(classInd + '/' + file):
			if file[-6:-4] > '07':
				j += 1
				print file + '/' + img + '	' + str(i) +   '	' + str(j)