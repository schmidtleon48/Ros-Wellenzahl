#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Point
from sensor_msgs.msg import PointCloud2
import std_msgs.msg

rospy.init_node('subscriberown')

def callback(msg):
	print(msg)

sub = rospy.Subscriber("/my_pcl_topic", PointCloud2, callback)

rospy.spin()
