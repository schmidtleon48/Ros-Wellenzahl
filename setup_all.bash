#!/bin/bash

printf "
Dieses Script visualisiert mit Hilfe von Rviz die Pointcloud von dem Radar-Sensor.
Stellen Sie sicher, dass das Gerät mit dem Sensor läuft und über ssh erreicht werden kann und Sie Ros und das erforderliche Wellenzahl-Packet, sowohl auf ihrer Maschiene, als auch auf dem Gerät mit dem Sensor, installiert haben. Sie können das Wellenzahl-Package unter ____ herunterladen. Wenn Sie noch kein Ros auf ihrem Gerät mit Sensor haben, können Sie das Installationsskript ausführen.\n\n\n\n"

echo "Geben Sie die IP des Rosmasters mit Sensor an:"
read ip

echo "Geben Sie den Benutzernamen des Rosmsters mit Sensor an:"
read ben

echo "Geben Sie den Namen des Ros-Workspaces auf dem Gerät mit dem Sensor an:"
read ws

echo "Geben Sie den Namen des Ros-Workspaces auf ihrem Gerät ein:"
read ws1

cd

ssh $ben@$ip<<EOF
tmux new -s 1
cd
cd $ws
catkin_make
source devel/setup.bash
sudo killall -9 rosmaster
export ROS_MASTER_URI=http://$ip:11311
export ROS_IP=$ip
rot="\033[31m"
echo -e "${rot}Sie müssen STRG + c drücken, SOBALD DER MASTER LÄUFT!!!"
roscore & rosrun wellenzahl publisher.py & tmux detach
EOF

cd $ws1
catkin_make
source devel/setup.bash
export ROS_MASTER_URI=http://$ip:11311
rosrun wellenzahl subscriber.py & rviz & rqt_graph
