#!/bin/bash

echo "Geben Sie die IP-Adresse ein, wo Sie Ros installieren wollen"
read IP

echo "Geben Sie den Benutzernamen ein, wo Sie Ros installieren wollen"
read ben

ssh $ben@$IP<<EOF


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

cd src 

catkin_create_pkg wellenzahl rospy

cd

scp -r ~/catkin_ws/src/wellenzahl/src $ben@$IP:~/catkin_ws/src/wellenzahl/
EOF
