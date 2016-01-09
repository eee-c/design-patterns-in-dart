library universal_remote;

import 'dart:mirrors';

import 'robot.dart' as oscorp;
import 'async_robot.dart' as tyrell;

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

  InstanceMirror get _ubot {
    // var im = reflect(robot);

    // print(im.type.owner.location);
    // print(im.type.simpleName);
    // print(reflect(this).type.owner.libraryDependencies[3].targetLibrary.location);

    // print(reflect(this).type.owner.declarations);

    // Symbol adapterClassName = new Symbol('${im.type.reflectedType.toString()}AdapterToUbot');



    // print(adapterClassName);
    LibraryMirror thisLibrary = reflect(this).type.owner;

    Symbol adapterClassName = new Symbol('${robot.runtimeType}AdapterToUbot');
    var adapterClass = thisLibrary.declarations[adapterClassName];
    if (adapterClass == null) return reflect(new NullAdapterToUbot(robot));

    Symbol constructor = new Symbol('');
    return adapterClass.newInstance(constructor, [robot]);

    // if (robot is oscorp.Robot) return reflect(new RobotAdapterToUbot(robot));
    // if (robot is tyrell.Bot)   return reflect(new BotAdapterToUbot(robot));
    // return reflect(new NullAdapterToUbot(robot));
  }

   dynamic noSuchMethod(i) => _ubot.delegate(i);
}

/*** Adapters ***/
class RobotAdapterToUbot implements Ubot {
  oscorp.Robot _robot;
  RobotAdapterToUbot(this._robot);

  String get xyLocation => _robot.location;

  void moveForward()  { _robot.move(oscorp.Direction.NORTH); }
  void moveBackward() { _robot.move(oscorp.Direction.SOUTH); }
  void moveLeft()     { _robot.move(oscorp.Direction.WEST); }
  void moveRight()    { _robot.move(oscorp.Direction.EAST); }
}

class BotAdapterToUbot implements Ubot {
  tyrell.Bot _bot;
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
