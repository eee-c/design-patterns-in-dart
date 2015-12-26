library robot;

import 'dart:math';
import 'dart:mirrors';

enum Direction { NORTH, SOUTH, EAST, WEST }

final rand = new Random(3);

// Invoker
class Button {
  String name;
  Function command;
  Button(this.name, this.command);

  void press() {
    print("[pressed] $name");
    command.call();
    History.add(command);
  }
}

class History {
  List _undoCommands = [];
  List _redoCommands = [];

  static final History _h = new History._internal();
  factory History() => _h;
  History._internal();

  static void add(Function c) {
    if (!reflect(c).type.instanceMembers.containsKey(#undo)) return;

    _h._undoCommands.add(c);
  }

  void undo() {
    var h = _undoCommands.removeLast();
    print("Undoing $h");
    h.undo();
    _redoCommands.add(h);
  }
  void redo() {
    var h = _redoCommands.removeLast();
    print("Re-doing $h");
    h.call();
    _undoCommands.add(h);
  }
}


class Robot {
  Camera camera;
  int x=0, y=0;
  Robot() {
    camera = new Camera();
  }
  String get location => "$x, $y";
  void move(direction) {
    print("  I am moving $direction");
    switch (direction) {
      case Direction.NORTH:
        y++;
        break;
      case Direction.SOUTH:
        y--;
        break;
      case Direction.EAST:
        x++;
        break;
      case Direction.WEST:
        x--;
        break;
    }
  }
  void say(String something) { print(something); }
}

class Camera {
  bool isRecording = false;
  void startRecording() {
    print('  Capturing video record');
    isRecording = true;
  }
  void stopRecording() {
    print('  Video record complete');
    isRecording = false;
  }
}

abstract class Command implements Function {
  void call();
}

class SimpleCommand<T> implements Command {
  T receiver;
  Symbol action;
  List args=[];
  SimpleCommand(this.receiver, this.action, [this.args]);
  void call() {
    reflect(receiver).invoke(action, this.args);
  }
}

class MoveNorthCommand implements Command {
  Robot robot;
  MoveNorthCommand(this.robot);
  void call() { robot.move(Direction.NORTH); }
  void undo() { robot.move(Direction.SOUTH); }
}

class MoveSouthCommand implements Command {
  Robot robot;
  MoveSouthCommand(this.robot);
  void call() { robot.move(Direction.SOUTH); }
  void undo() { robot.move(Direction.NORTH); }
}

class MoveEastCommand implements Command {
  Robot robot;
  MoveEastCommand(this.robot);
  void call() { robot.move(Direction.EAST); }
  void undo() { robot.move(Direction.WEST); }
}

class MoveWestCommand implements Command {
  Robot robot;
  MoveWestCommand(this.robot);
  void call() { robot.move(Direction.WEST); }
  void undo() { robot.move(Direction.EAST); }
}

class DanceHappyCommand implements Command {
  Robot robot;
  int _prevX, _prevY;
  DanceHappyCommand(this.robot);
  void call() {
    _prevX = robot.x;
    _prevY = robot.y;
    for (var i=0; i<8; i++) {
      // robot.move(Direction.values[rand.nextInt(4)]);
      int r = rand.nextInt(4);
      if (r==0) new MoveNorthCommand(robot).call();
      if (r==1) new MoveSouthCommand(robot).call();
      if (r==2) new MoveEastCommand(robot).call();
      if (r==3) new MoveWestCommand(robot).call();
    }
  }
  void undo() {
    var dir;

    dir = robot.x > _prevX ? Direction.WEST : Direction.EAST;
    while (robot.x != _prevX) {
      robot.move(dir);
    }

    dir = robot.y > _prevY ? Direction.SOUTH : Direction.NORTH;
    while (robot.y != _prevY) {
      robot.move(dir);
    }
  }
}

class StartRecordingCommand implements Command {
  Camera camera;
  StartRecordingCommand(this.camera);
  void call() { camera.startRecording(); }
  void undo() { camera.stopRecording(); }
}

class StopRecordingCommand implements Command {
  Camera camera;
  StopRecordingCommand(this.camera);
  void call() { camera.stopRecording(); }
  void undo() { camera.startRecording(); }
}

class UndoCommand implements Command {
  History history;
  UndoCommand(this.history);
  void call() { history.undo(); }
}

class RedoCommand implements Command {
  History history;
  RedoCommand(this.history);
  void call() { history.redo(); }
}
