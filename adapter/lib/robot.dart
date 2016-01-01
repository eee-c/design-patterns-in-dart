library robot;

enum Direction { NORTH, SOUTH, EAST, WEST }

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
