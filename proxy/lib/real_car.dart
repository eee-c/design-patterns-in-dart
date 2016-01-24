library car;

import 'dart:async' show Future, Stream;
import 'dart:io' show WebSocket;

import 'interface.dart';

// Adaptee
class Car implements Automobile {
  String state = 'idle';
  void drive() { state = 'driving'; }
  void stop()  { state = 'idle'; }
}

// Real Subject & Adapter
class AsyncCar implements AsyncAuto {
  WebSocket _socket;
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
