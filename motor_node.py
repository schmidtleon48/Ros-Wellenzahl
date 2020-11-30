#!/usr/bin/env python3

import rospy
import tf
from sensor_msgs import Pointcloud2
from std_msgs import Int32
from pic867.rotation_stage_device import RotationStage
import roslib

def callback(data):
    rot.set_angle(data)
    
def listener():

    rospy.init_node('motor', anonymous=True)
    rospy.Subscriber("steuerung",Int32 , callback)
    rate = rospy.Rate(10)
    rospy.Publisher("pointcloud", Pointcloud2, queue_size=10)
    br = tf.TransformBroadcaster()
    br.sendTransform((0, 0, 0),
                     tf.transformations.quaternion_from_euler(data, 0, 0),
                     rospy.Time.now(),
                     motor,
                     "world")
    rospy.spin()

if __name__ == '__main__':
    listener()