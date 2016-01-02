library universal_remote;

import 'dart:async';

import 'robot.dart';

abstract class Ubot {
  Timer moveForward();
  Timer moveBackward();
  Timer moveLeft();
  Timer moveRight();
  void stop();
}

const oneSecond = const Duration(seconds: 1);

class UbotRobot {
  Robot _robot;
  List<Timer> _activeControls = [];

  UbotRobot(this._robot);

  Timer moveForward()  => _move(Direction.NORTH);
  Timer moveBackward() => _move(Direction.SOUTH);
  Timer moveLeft()     => _move(Direction.WEST);
  Timer moveRight()    => _move(Direction.EAST);

  Timer _move(dir) {
    var t = new Timer.periodic(oneSecond, (_){ _robot.move(dir); });
    _activeControls.add(t);
    return t;
  }

  void stop() {
    while (_activeControls.isNotEmpty) {
      _activeControls.removeLast().cancel();
    }
  }
}
