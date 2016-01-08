library universal_remote;

import 'dart:mirrors';

import 'robot.dart';
import 'async_robot.dart';

/*** Target ***/
abstract class Ubot {
  String get xyLocation;
  void moveForward();
  void moveBackward();
  void moveLeft();
  void moveRight();
}

/*** Delegate / Target ***/
class UniversalRemoteRobot implements Ubot {
  var robot;
  UniversalRemoteRobot(this.robot);

  Ubot get _ubot {
    if (robot is Robot) return new RobotAdapterToUbot(robot);
    if (robot is Bot)   return new BotAdapterToUbot(robot);
    return new NullAdapterToUbot(robot);
  }

   dynamic noSuchMethod(i) => reflect(_ubot).delegate(i);
}

/*** Adapters ***/
class RobotAdapterToUbot implements Ubot {
  Robot _robot;
  RobotAdapterToUbot(this._robot);

  String get xyLocation => _robot.location;

  void moveForward()  { _robot.move(Direction.NORTH); }
  void moveBackward() { _robot.move(Direction.SOUTH); }
  void moveLeft()     { _robot.move(Direction.WEST); }
  void moveRight()    { _robot.move(Direction.EAST); }
}

class BotAdapterToUbot implements Ubot {
  Bot _bot;
  BotAdapterToUbot(this._bot);

  String get xyLocation => "${_bot.x}, ${_bot.y}";

  void moveForward()  { _bot.goForward(); }
  void moveBackward() { _bot.goBackward(); }
  void moveLeft()     { _bot.goLeft(); }
  void moveRight()    { _bot.goRight(); }
}

class NullAdapterToUbot implements Ubot {
  NullAdapterToUbot(_);

  String get xyLocation => "0, 0";

  void moveForward()  {}
  void moveBackward() {}
  void moveLeft()     {}
  void moveRight()    {}
}
