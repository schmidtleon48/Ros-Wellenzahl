#!/bin/bash

echo "Geben Sie Ihren ROS-Workspace ein"
read ws

echo "Geben Sie die Ip-Adresse des Masters an"
read ip

echo "Haben Sie schon das Wellenzahl-Package?(y/n)"
read ans
if [ ans=n];then
	cd
	cd $ws/src
	catkin_create_pkg wellenzahl rospy
	cd
	cd $ws/src/wellenzahl/src
	git init
	git clone https://github.com/schmidtleon48/wellenzahl.git
fi

cd 
cd $ws
catkin_make
source devel/setup.bash
export ROS_MASTER_URI=http://$ip:11311
export ROS_IP=$ip
roscore & rosrun wellenzahl publisher.py

