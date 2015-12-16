#!/usr/bin/env dart

import 'package:command_code/robot.dart';

// Client
main() {
  // Receivers
  var robot = new Robot();
  var camera = robot.camera;

  // Concrete command instances
  var moveNorth = new MoveNorthCommand(robot),
    moveSouth = new MoveSouthCommand(robot),
    moveEast = new MoveEastCommand(robot),
    moveWest = new MoveWestCommand(robot),
    startRecording = new StartRecordingCommand(camera),
    stopRecording = new StopRecordingCommand(camera);

  // Invokers
  var btnUp = new Button("Up", moveNorth);
  var btnDown = new Button("Down", moveSouth);
  var btnLeft = new Button("Left", moveWest);
  var btnRight = new Button("Down", moveEast);
  var btnRecord = new Button("Record", startRecording);
  var btnStopRecord = new Button("Stop Recording", stopRecording);

  btnUp.press();
  btnUp.press();
  btnUp.press();
  btnRight.press();
  btnRight.press();
  btnRight.press();
  btnLeft.press();
  btnDown.press();

  btnRecord.press();
  btnStopRecord.press();

  print("\nRobot is now at: ${robot.location}"
);
}