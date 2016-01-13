library car;

import 'dart:isolate';

// Subject
abstract class Automobile {
  String get state;
  void drive();
  void stop();
}

// Real Subject
class Car implements Automobile {
  SendPort _s;
  var _r;
  Car(this._r, this._s) {
    _r.listen((message) {
      print(message);
      if (message == #drive) drive();
      if (message == #stop)  stop();
      _s.send(state);
    });
  }

  String state = 'idle';
  void drive() { state = 'driving'; }
  void stop()  { state = 'idle'; }
}

// Proxy Subject
class ProxyCar implements Automobile {
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
  void drive() { _s.send(#drive); }
  void stop() { _s.send(#stop); }
}
