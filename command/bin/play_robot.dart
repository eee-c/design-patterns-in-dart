#!/usr/bin/env dart

import 'package:command_code/robot.dart';

// Client
main() {
  // Receivers
  var robot = new Robot();
  var camera = robot.camera;
  var history = new History();

  // Concrete command instances
  var moveNorth = new MoveNorthCommand(robot),
    moveSouth = new MoveSouthCommand(robot),
    moveEast = new MoveEastCommand(robot),
    moveWest = new MoveWestCommand(robot),
    danceHappy = new DanceHappyCommand(robot),
    startRecording = new StartRecordingCommand(camera),
    stopRecording = new StopRecordingCommand(camera),
    undo = new UndoCommand(history),
    redo = new RedoCommand(history);

  // Invokers
  var btnUp = new Button("Up", moveNorth);
  var btnDown = new Button("Down", moveSouth);
  var btnLeft = new Button("Left", moveWest);
  var btnRight = new Button("Down", moveEast);
  var btnHappyDance = new Button("Happy Dance", danceHappy);
  var btnRecord = new Button("Record", startRecording);
  var btnStopRecord = new Button("Stop Recording", stopRecording);
  var btnUndo = new Button("Undo", undo);
  var btnRedo = new Button("Redo", redo);

  btnHappyDance.press();
  print("\nRobot is now at: ${robot.location}");
  print("--\n");

  btnUndo.press();
  print("\nRobot is now at: ${robot.location}");
  print("--\n");

  btnUp.press();
  btnUp.press();
  btnUp.press();

  btnUndo.press();
  btnUndo.press();
  btnRedo.press();

  print("\nRobot is now at: ${robot.location}");
  print("--\n");

  btnRight.press();
  btnRight.press();
  btnRight.press();
  btnLeft.press();
  btnDown.press();

  btnRecord.press();
  btnStopRecord.press();

  print("\nRobot is now at: ${robot.location}");
}
