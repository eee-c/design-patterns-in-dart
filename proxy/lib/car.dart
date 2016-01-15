library car;

import 'dart:async';
import 'dart:isolate';

abstract class Automobile {
  String get state;
  void drive();
  void stop();
}

// Adaptee
class Car implements Automobile {
  String state = 'idle';
  void drive() { state = 'driving'; }
  void stop()  { state = 'idle'; }
}

// Subject
abstract class AsyncAuto implements Automobile {
  String get state;
  void drive();
  void stop();
}

// Real Subject & Adapter
class AsyncCar implements AsyncAuto {
  SendPort _s;
  ReceivePort _r;
  Car _car;
  AsyncCar(this._r, this._s) {
    _car = new Car();

    _r.listen((message) {
      print("[AsyncCar] $message");
      if (message == #drive) _car.drive();
      if (message == #stop)  _car.stop();
      _s.send(state);
    });
  }

  String get state => _car.state;
  Future drive() => new Future((){ _car.drive(); });
  Future stop()  => new Future((){ _car.stop(); });
}

// Proxy Subject
class ProxyCar implements AsyncAuto {
  SendPort _s;
  var _r;
  String _state = "???";

  ProxyCar(this._r, this._s) {
    _r.listen((message) {
      print("[ProxyCar] $message");
      _state = message;
    });
  }

  String get state => _state;
  Future drive() => _send(#drive);
  Future stop()  => _send(#stop);

  Future _send(message) {
    _s.send(message);
    return _r.first;
  }
}
