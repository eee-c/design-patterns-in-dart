library car;

import 'dart:async' show Future, Stream;
import 'dart:html' show WebSocket;

import 'interface.dart';

// Proxy Subject
class ProxyCar implements AsyncAuto {
  WebSocket _socket;
  String _state;

  ProxyCar(this._socket) {
    _socket.onMessage.listen((e) {
      // print("[ProxyCar] received: $message");
      _state = e.data;
    });
  }

  String get state => _state;
  Future drive() => _send('drive');
  Future stop()  => _send('stop');

  Future _send(message) {
    _socket.send(message);
    return _socket.onMessage.first;
  }
}
