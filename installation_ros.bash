#!/bin/bash

echo "Geben Sie die IP-Adresse ein, wo Sie Ros installieren wollen"
read IP

echo "Geben Sie den Benutzernamen ein, wo Sie Ros installieren wollen"
read ben

ssh $ben@$IP<<EOF

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt update

sudo apt install -y ros-noetic-desktop-full

source /opt/ros/noetic/setup.bash

echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt-get install python3-rosdep

sudo rosdep init

rosdep update

cd

mkdir catkin_ws

cd catkin_ws

mkdir src

catkin_make

source devel/setup.bash
EOF
