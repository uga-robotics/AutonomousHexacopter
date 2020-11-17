# AutonomousHexacopter
any and all ROS/ROS2 Packages used in the development of an Autonomous Hexacopter, with the aim of achieving basic autonomous capabilities along with autonomous battery swapping

## Cloning/Importing into a workspace
If you would like to use this repository in a catkin/colcon workspace, simply clone it into the src/ directory from the workspace root:
```
git clone {https/ssh ref} src/AutonomousHexacopter
```
Also, remember to setup the submodule repositories by using this two command in the /AutonomousHexacopter directory
```
git submodule update --init --recursive
```

## Installing Dependancies and Setup
Once you clone the repository, navigate to the `scripts` directory and run the `install_deps.sh` script like so:
```
sudo ./install_deps.sh
```
After that, please follow the instructions found [here](https://fast-dds.docs.eprosima.com/en/latest/installation/binaries/binaries_linux.html) to install FastRTPS and FastRTPSGen. Note that this step is critically important, as FastRTPS and FastRTPSGen allow the PX4 to communicate with ROS2.

## Building the Workspace
After making sure the git submodules are properly initialized and updated (the directories are not empty) and installing the required dependancies, you should be able to build the ROS2 workspace with `colcon` as shown below. Navigate to the root of the workspace (above `src`) and execute the following command, making sure ROS2 is sourced:
```
colcon build --symlink-install --packages-skip px4 --event-handlers console_direct+
```

## Running the Stock SITL Gazebo Simulation and Connecting it to ROS2
To run the stock Software In The Loop (SITL) Gazebo simulation, with an example quadcopter, navigate to the `PX4-Autopilot` directory and execute the command:
```
make px4_sitl_rtps gazebo
```
This will build an SITL version of the PX4 firmware with RTPS enabled, then launch and connect with the stock quadcopter (specifically an IRIS quadcopter) Gazebo simulation window. The terminal will then be displaying the PX4 terminal, from which we can run:
```
micrortps_client start -t UDP
```
To start the RTPS client on the PX4 firmware.

Next, to start the ROS2 side of the bridge, make sure the ROS2 workspace is built, then source the `install/setup.bash` script to include the built files/executables. Now from the root directory of the workspace, run:
```
micrortps_agent -t UDP
```
Which should display some output pertaining to the topics subscribed to and published to.

Then, run any ROS2 executable connecting to the bridge, as an example we'll use the `sensor_combined_listener` executable from the `px4_ros_com` package. Again, execute the command from the root of the workspace:
```
ros2 launch px4_ros_com sensor_combined_listener.launch.py 
```
You should see some nominal data coming fom the `sensor_combined` uORB topic on the PX4!

## Cleaning Up Before Committing Changes

***Before commiting any changes to this repository, please do the following!!!!***

To clean up the repo for commits, please make sure to delete the `PX4-Autopilot/build` directory. It contains system-specific files generated when starting the SITL Gazebo simulation, and should be deleted! To do this, navigate to the `PX4-Autopilot` directory and execute the following command:
```
sudo rm -r build/
```