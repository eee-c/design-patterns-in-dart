import 'dart:html';

import 'dart:async' show Completer;

main() {
  var message = new FormMessage(query('#message'));

  query('#save').
    onClick.
    listen((_){
      message.send();
    });

  queryAll('[name=implementor]').
    onChange.
    listen((e) {
      var input = e.target;
      if (!input.checked) return;
      print(input);
      if (input.value == 'http')
        message.comm = new HttpCommunicator();
      else
        message.comm = new WebSocketCommunicator();
    });
}

// Implementor
abstract class Communicator {
  void save(String message);
}

// Concrete Implementor 1
class HttpCommunicator implements Communicator {
  void save(message) {
    HttpRequest.postFormData('/save', {'message': message});
  }
}

// Concrete Implementor 2
class WebSocketCommunicator implements Communicator {
  WebSocket _socket;
  WebSocketCommunicator() { _startSocket(); }

  _startSocket() async {
    _socket = new WebSocket('ws://localhost:4040/ws');

    var _c = new Completer();
    _socket.onOpen.listen((_){ _c.complete(); });
    await _c.future;
  }

  void save(message) {
    _socket.send(message);
  }
}

// Abstraction
abstract class Message {
  Communicator comm;
  Message(this.comm);
  void send();
}

// Refined Abstraction
class FormMessage extends Message {
  Element _messageElement;
  FormMessage(this._messageElement) : super(new HttpCommunicator());

  void send() {
    comm.save(message);
  }

  String get message => _messageElement.value;
}
