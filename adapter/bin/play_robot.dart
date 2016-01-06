#!/usr/bin/env dart

import 'dart:async';

import 'package:adapter_code/robot.dart';
import 'package:adapter_code/async_robot.dart';
import 'package:adapter_code/universal_remote.dart';

main() {
  var robot = new Robot();
  // This works exactly the same:
  // var robot = new Bot();

  var universalRobot = new UniversalRemoteRobot(robot);

  print("Start moving $robot.");
  var btnCtrl = universalRobot.moveForward();

  // Simulate releasing the button after 10 seconds...
  new Timer(
    new Duration(seconds: 10),
    (){
      btnCtrl.cancel();
      print("The robot is now at: ${universalRobot.xyLocation}.");
    }
  );
}
