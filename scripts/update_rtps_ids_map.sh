#!/bin/sh

# Only execute this script from the workspace root (hexacopter_ws, test_ws, etc.)
python3 src/PX4-Autopilot/msg/tools/uorb_to_ros_rtps_ids.py -i src/PX4-Autopilot/msg/tools/uorb_rtps_message_ids.yaml -o src/px4_ros_com/templates/uorb_rtps_message_ids.yaml