#!/usr/bin/env python3

import rospy
import tf
from sensor_msgs import Pointcloud2

def callback(data):
    print(Pointcloud2)
    
def listener():
    rospy.init_node('empfang', anonymous=True)
    rospy.Subscriber("pointcloud",Pointcloud2 , callback)
    rospy.spin()

if __name__ == '__main__':
    listener()