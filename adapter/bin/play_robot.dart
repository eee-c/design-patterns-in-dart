#!/usr/bin/env dart

import 'dart:async';

import 'package:adapter_code/robot.dart';
import 'package:adapter_code/universal_remote.dart';

main() {
  var robot = new Robot();
  var universalRobot = new UbotRobot(robot);

  print("Start moving the robot.");

  var btnCtrl = universalRobot.moveForward();

  // Simulate the button being release 10 seconds later...
  new Timer(
    new Duration(seconds: 10),
    (){
      btnCtrl.cancel();
      print("The robot is now at: ${robot.location}.");
    }
  );

  // The non-adapted, procedural version of the code:
  // robot
  //   ..move(Direction.NORTH)
  //   ..move(Direction.NORTH)
  //   ..move(Direction.NORTH)
  //   ..move(Direction.NORTH)
  //   ..move(Direction.NORTH);
  // print("The robot is now at: ${robot.location}.");
}
