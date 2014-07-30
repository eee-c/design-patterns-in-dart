part of reactor;

class LoggingAcceptor implements EventHandler {
  LoggingAcceptor() {
    new InitiationDispatcher().registerHandler(this, 'log_connect');
  }

  void handleEvent(connection) {
    if (connection['type'] != 'log_connect') return;
    new LoggingHandler(connection['value']);
  }
}

class LoggingHandler implements EventHandler {
  StreamController _out;
  StreamController _in;

  StreamSubscription handle;

  final timeout = const Duration(milliseconds: 2);

  LoggingHandler(StreamController this._out) {
    new InitiationDispatcher()
      ..registerHandler(this, 'log')
      ..registerHandler(this, 'log_close');

    _in = new StreamController.broadcast();
    _out.add(_in);

    handle = _in.
      stream.
      timeout(timeout, onTimeout: (_){ handle.pause(); }).
      listen(write)
      ..pause();
  }

  void handleEvent(event) {
    if (event['type'] == 'log') {
      read();
    }
    else if (event['type'] == 'log_close') {
      handle.cancel();
      _in.close();
      new InitiationDispatcher()
        ..removeHandler(this, 'log')
        ..removeHandler(this, 'log_close');
    }
  }

  void read() {
    handle.resume();
  }

  void write(message) {
    print('[LoggingHandler.write] $message');
  }
}
