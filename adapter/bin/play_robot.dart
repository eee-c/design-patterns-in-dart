#!/usr/bin/env dart

import 'package:adapter_code/robot.dart';
import 'package:adapter_code/async_robot.dart';
import 'package:adapter_code/universal_remote.dart';

main() {
  var robot = new Robot();
  var universalRobot = new UbotRobot(robot);

  print("Start moving the robot.");
  universalRobot
    ..moveForward()
    ..moveForward()
    ..moveForward()
    ..moveForward()
    ..moveForward();
  print("The robot is now at: ${universalRobot.location}.");


  // The non-adapted, procedural version of the code:
  // robot
  //   ..move(Direction.NORTH)
  //   ..move(Direction.NORTH)
  //   ..move(Direction.NORTH)
  //   ..move(Direction.NORTH)
  //   ..move(Direction.NORTH);
  // print("The robot is now at: ${robot.location}.");
}
