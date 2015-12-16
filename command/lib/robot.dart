library robot;

enum Direction { NORTH, SOUTH, EAST, WEST }

// Invoker
class Button {
  static List _history = [];

  String name;
  Command command;
  Button(this.name, this.command);

  void press() {
    print("[pressed] $name");
    command.call();
    _history.add(command);
  }

  static void undo() {
    var h = _history.removeLast();
    print("Undoing $h");
    h.undo();
  }

  static void undoAll() {
    _history.forEach((h) { print(h); });
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
}

class MoveSouthCommand implements Command {
  Robot robot;
  MoveSouthCommand(this.robot);
  void call() { robot.move(Direction.SOUTH); }
}

class MoveEastCommand implements Command {
  Robot robot;
  MoveEastCommand(this.robot);
  void call() { robot.move(Direction.EAST); }
}

class MoveWestCommand implements Command {
  Robot robot;
  MoveWestCommand(this.robot);
  void call() { robot.move(Direction.WEST); }
}

class StartRecordingCommand implements Command {
  Camera camera;
  StartRecordingCommand(this.camera);
  void call() { camera.startRecording(); }
}

class StopRecordingCommand implements Command {
  Camera camera;
  StopRecordingCommand(this.camera);
  void call() { camera.stopRecording(); }
}
