library universal_remote;

import 'dart:mirrors';

import 'robot.dart';
import 'async_robot.dart';

abstract class Ubot {
  void moveForward();
  void moveBackward();
  void moveLeft();
  void moveRight();
}

class UbotRobot implements Ubot {
  var _robot;
  UbotRobot(this._robot);

  static Map<Type, Map> _registry = {
    Robot: {
      'forward':  [#move, [Direction.NORTH]],
      'backward': [#move, [Direction.SOUTH]],
      'left':     [#move, [Direction.WEST]],
      'right':    [#move, [Direction.EAST]]
    },
    Bot: {
      'forward':  [#goForward, []],
      'backward': [#goBackward, []],
      'left':     [#goLeft, []],
      'right':    [#goRight, []]
    }
  };

  String get location {
    if (_robot is Robot) return _robot.location;
    if (_robot is Bot) return "${_robot.x}, ${_robot.y}";
    return "";
  }

  void moveForward() {
    var _ = _registry[_robot.runtimeType]['forward'];
    reflect(_robot).invoke(_[0], _[1]);
  }
  void moveBackward() {
    var _ = _registry[_robot.runtimeType]['backward'];
    reflect(_robot).invoke(_[0], _[1]);
  }
  void moveLeft() {
    var _ = _registry[_robot.runtimeType]['left'];
    reflect(_robot).invoke(_[0], _[1]);
  }
  void moveRight() {
    var _ = _registry[_robot.runtimeType]['right'];
    reflect(_robot).invoke(_[0], _[1]);
  }
}
