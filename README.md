# AutonomousHexacopter
any and all software packages used in the development of an Autonomous Hexacopter, with the aim of achieving basic autonomous capabilities along with autonomous battery swapping, facilitated by the PX4-Autopilot FMU firmware, ROS2, and their dependancies.

**NOTE:** This repo is mean't for use with ROS2 Foxy on Ubuntu 20.04 LTS. Make sure you have these installed correctly by following [this](https://github.com/uga-robotics/ROS2-training/blob/master/instructions/introduction.md) guide before continuing with this one!

## Cloning/Importing Into a New Workspace
If you would like to use this repository in a catkin/colcon workspace, simply clone it into the src/ directory from the workspace root:
```
git clone {https/ssh ref} src/AutonomousHexacopter
```
Also, remember to setup the submodule repositories by using this two command in the /AutonomousHexacopter directory
```
git submodule update --init --recursive
```
Then, make sure to checkout the `fork_master` branch for the `PX4-Autopilot` submodule so you can record changes to it:
```
cd PX4-Autopilot
git checkout fork_master
```
Repeat this for any submodule you with to make changes to.

## Installing Dependancies and Setup
Once you clone the repository, navigate to the `scripts` directory and run the `install_deps.sh` script like so:
```
sudo ./install_deps.sh
```
After that, please follow the instructions found [here to install FastRTPS and FastRTPSGen via Linux Binaries](https://fast-dds.docs.eprosima.com/en/latest/installation/binaries/binaries_linux.html) or [here to install them via Sources](https://fast-dds.docs.eprosima.com/en/latest/installation/binaries/binaries_linux.html). Although the binaries are available, we recommend to build and install the code from source, given that the binaries may not come with required components and dependencies in place. Note that this step is critically important, as FastRTPS and FastRTPSGen allow the PX4 to communicate with ROS2.

## Building the Workspace
After making sure the git submodules are properly initialized and updated (the directories are not empty) and installing the required dependancies, you should be able to build the ROS2 workspace with `colcon` as shown below. Navigate to the root of the workspace (above `src`) and execute the following command, making sure ROS2 is sourced:
```
colcon build --symlink-install --packages-skip px4 --event-handlers console_direct+
```

## Running the Stock SITL Gazebo Simulation and Connecting it to ROS2
Before running Gazebo, the Ignition rendering API must be installed, which won't install unless sourced directly. To install, execute the following commands in order:
```
sudo apt -y install wget lsb-release gnupg
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt update
sudo apt install libignition-rendering3-dev
```
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

## Working with Git and Git Submodules
**NOTE:** If you have made changes to any of the submodules (PX4-Autopilot, PX4-msgs, px4_ros_com, etc.), make sure to navigate into their respective directories and push those changes **BEFORE** attempting to push changes in the main repository.

More information on using/working with Git can be found [here](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control)

And more information on working with Git Submodules specifically can be found [here](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
