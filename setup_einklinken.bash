#!/bin/bash

printf "Dieses Skript wird angewandt, wenn der Master schon läuft und Sie die Pointcloud abgreifen wollen und mit Rviz visuallisieren"

echo "Geben Sie Ihren ROS-Workspace ein"
read ws

echo "Geben Sie die Ip-Adresse des Masters an"
read ip

echo "Haben Sie schon ROS auf ihrem Ubuntu-PC?(y/n)"
read ans1
if [ ans1=n];then
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt update
	sudo apt install -y ros-noetic-desktop-full
	source /opt/ros/noetic/setup.bash
	echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
	source ~/.bashrc
	sudo apt-get install python3-rosdep
	sudo rosdep init
	rosdep update
	mkdir catkin_ws
	cd catkin_ws
	mkdir src
	catkin_make
	source devel/setup.bash
fi

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
rosrun wellenzahl subscriber.py & rviz & rqt_graph

printf "Damit Ihnen die Pointcloud angezeigt wird, müssen Sie jetzt am unteren linken Rand auf Add --> Pointcloud2 und dann das vorhandene Topic auswählen"
