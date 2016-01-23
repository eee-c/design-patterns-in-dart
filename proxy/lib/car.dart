library car;

import 'dart:async';

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
  StreamController _socket;
  Car _car;

  AsyncCar(this._socket) {
    _car = new Car();

    _socket.stream.where((m)=> m is! String).listen((message) {
      print("[AsyncCar] $message");
      if (message == #drive) _car.drive();
      if (message == #stop)  _car.stop();
      _socket.add(state);
    });
  }

  String get state => _car.state;
  Future drive() => new Future((){ _car.drive(); });
  Future stop()  => new Future((){ _car.stop(); });
}

// Proxy Subject
class ProxyCar implements AsyncAuto {
  StreamController _socket;
  String _state = "???";

  ProxyCar(this._socket) {
    _socket.stream.where((m)=> m is! Symbol).listen((message) {
      print("[ProxyCar] $message");
      _state = message;
    });
  }

  String get state => _state;
  Future drive() => _send(#drive);
  Future stop()  => _send(#stop);

  Future _send(message) {
    _socket.add(message);
    return _socket.stream.first;
  }
}
