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
      if (message == #drive) drive();
      if (message == #stop)  stop();
    });
  }

  String get state => _car.state;
  Future drive() => new Future((){
    _car.drive();
    _s.send(state);
  });
  Future stop() => new Future((){
    _car.stop();
    _s.send(state);
  });
}

// Proxy Subject
class ProxyCar implements AsyncAuto {
  String state = "???";

  Talker _t;

  ProxyCar() {
    _t = new Talker();
  }

  Future drive() => _send(#drive);
  Future stop()  => _send(#stop);

  SendPort get sendPort => _t.sendPort;
  Future get ready => _t.ready;

  Future _send(message) =>
    _t.
      send(message).
      then((response){
        print("[ProxyCar] $response");
        state = response;
      });
}

class Talker {
  SendPort _s;
  ReceivePort _r;
  Stream _inStream;
  Future ready;

  Talker() {
    _r = new ReceivePort();
    _inStream = _r.asBroadcastStream();
    ready = _inStream.first.then((message){
      _s = message;
    });
  }

  // For others to talk to us
  SendPort get sendPort => _r.sendPort;

  Future send(message) {
    _s.send(message);
    return _inStream.first;
  }

}
