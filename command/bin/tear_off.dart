#!/usr/bin/env dart

class Robot {
  int x=0, y=0;
  String get xyLocation => "$x, $y";
  void moveForward() { y++; }
}

main () {
  var robot = new Robot();
  var loc = robot#xyLocation;
  var c = robot.moveForward;

  // Regular method invocation...
  robot.moveForward();

  // Tear-off method invocations...
  c();
  print("The robot is now at: ${loc()}.");
}
