#!/usr/bin/env python
import rospy
import math
import sys
import random

from sensor_msgs.msg import PointCloud2
import std_msgs.msg
import sensor_msgs.point_cloud2 as pcl2

random.seed()

if __name__ == '__main__':

    rospy.init_node('pcl2_pub_example')
    pcl_pub = rospy.Publisher("/my_pcl_topic", PointCloud2, queue_size=10)

    rospy.sleep(1.)

    while not rospy.is_shutdown():
    	header = std_msgs.msg.Header()
    	header.stamp = rospy.Time.now()
    	header.frame_id = 'map'
    	cloud_points = [[random.uniform(0,5), random.uniform(0,5), random.uniform(0,5)],[random.uniform(0,5), random.uniform(0,5), random.uniform(0,5)]]
    	scaled_polygon_pcl = pcl2.create_cloud_xyz32(header, cloud_points)
    	pcl_pub.publish(scaled_polygon_pcl)
