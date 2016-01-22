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
  Future drive();
  Future stop();
}

// Real Subject & Adapter
class AsyncCar implements AsyncAuto {
  Stream _socket;
  Car _car;

  AsyncCar(this._socket) {
    _car = new Car();

    _socket.listen((message) {
      print("[AsyncCar] received: $message");
      if (message == 'drive') _car.drive();
      if (message == 'stop')  _car.stop();
      _socket.add(state);
    });
  }

  String get state => _car.state;
  Future drive() => new Future((){ _car.drive(); });
  Future stop()  => new Future((){ _car.stop(); });
}

// Proxy Subject
class ProxyCar implements AsyncAuto {
  Stream _socket, _broadcast;
  String _state;

  ProxyCar(this._socket) {
    _broadcast = _socket.asBroadcastStream();
    _broadcast.listen((message) {
      // print("[ProxyCar] received: $message");
      _state = message;
    });
  }

  String get state => _state;
  Future drive() => _send('drive');
  Future stop()  => _send('stop');

  Future _send(message) {
    _socket.add(message);
    return _broadcast.first;
  }
}
