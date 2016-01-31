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

// Abstraction
abstract class Messenger {
  Communication comm;
  Messenger(this.comm);
  void updateStatus();
}

// Refined Abstraction
class WebMessenger extends Messenger {
  InputElement _messageElement;
  List _history = [];

  WebMessenger(this._messageElement) :
    super(new HttpCommunication());

  void updateStatus() {
    comm.send(message);
    _log(message);
    _maybeChangeCommunication();
  }

  void _log(message) {
    _history.add([new DateTime.now(), message]);
  }

  _maybeChangeCommunication() {
    if (_history.length < 3) return;

    var last = _history.length - 1,
      dateOld = _history[last-2][0],
      dateNew = _history[last][0],
      diff = dateNew.difference(dateOld);

    if (diff.inSeconds < 10) {
      if (comm is! WebSocketCommunication)
        comm = new WebSocketCommunication();
    }
    else {
      if (comm is! HttpCommunication)
        comm = new HttpCommunication();
    }
  }

  String get message => _messageElement.value;
}
