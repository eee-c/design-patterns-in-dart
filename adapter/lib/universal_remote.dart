library universal_remote;

import 'robot.dart';
import 'async_robot.dart';

abstract class Ubot {
  void moveForward();
  void moveBackward();
  void moveLeft();
  void moveRight();
}

class UbotRobot {
  var _robot;
  UbotRobot(this._robot);

  bool get isRobot => _robot is Robot;
  bool get isBot   => _robot is Bot;

  String get location {
    if (isRobot) return _robot.location;
    if (isBot) return "${_robot.x}, ${_robot.y}";
    return "";
  }

  void moveForward() {
    if (isRobot) _robot.move(Direction.NORTH);
    if (isBot) _robot.goForward();
  }
  void moveBackward() {
    if (isRobot) _robot.move(Direction.SOUTH);
    if (isBot) _robot.goBackward();
  }
  void moveLeft() {
    if (isRobot) _robot.move(Direction.WEST);
    if (isBot) _robot.goLeft();
  }
  void moveRight() {
    if (isRobot) _robot.move(Direction.EAST);
    if (isBot) _robot.goRight();
  }
}
