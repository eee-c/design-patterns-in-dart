library car;

import 'dart:async' show Future, Stream;
import 'dart:io' show WebSocket;

import 'interface.dart';

// Proxy Subject
class ProxyCar implements AsyncAuto {
  WebSocket _socket;
  Stream _broadcast;
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
