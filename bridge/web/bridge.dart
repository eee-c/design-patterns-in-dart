import 'dart:html';

import 'dart:async' show Completer;

main() {
  var message = new WebMessenger(query('#message'));

  query('#save').
    onClick.
    listen((_){
      message.updateStatus();
    });

  queryAll('[name=implementor]').
    onChange.
    listen((e) {
      var input = e.target;
      if (!input.checked) return;

      if (input.value == 'http')
        message.comm = new HttpCommunication();
      else
        message.comm = new WebSocketCommunication();
    });
}

// Implementor
abstract class Communication {
  void send(String message);
}

// Concrete Implementor 1
class HttpCommunication implements Communication {
  void send(message) {
    HttpRequest.postFormData('/status', {'message': message});
  }
}

// Concrete Implementor 2
class WebSocketCommunication implements Communication {
  WebSocket _socket;
  WebSocketCommunication() { _startSocket(); }

  _startSocket() async {
    _socket = new WebSocket('ws://localhost:4040/ws');

    var _c = new Completer();
    _socket.onOpen.listen((_){ _c.complete(); });
    await _c.future;
  }

  void send(message) {
    _socket.send("message=$message");
  }
}

// Degenerate Abstraction
class WebMessenger  {
  Communication comm;
  InputElement _messageElement;
  WebMessenger(this._messageElement) : comm = new HttpCommunication();

  void updateStatus() {
    comm.send(message);
  }

  String get message => _messageElement.value;
}
