library robot;

enum Direction { NORTH, SOUTH, EAST, WEST }

// Invoker
class Button {
  String name;
  Command command;
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

  static void add(Command c) {
    if (c.runtimeType == UndoCommand) return;
    if (c.runtimeType == RedoCommand) return;

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

abstract class Command {
  void call();
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
