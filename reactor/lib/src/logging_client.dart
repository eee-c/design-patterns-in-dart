part of reactor;

class LoggingAcceptor implements EventHandler {
  LoggingAcceptor() {
    new InitiationDispatcher().registerHandler(this, 'log_connect');
  }

  void handleEvent(connection) {
    if (connection.type != 'log_connect') return;
    new LoggingHandler(connection.value);
  }
}

class LoggingHandler implements EventHandler {
  SendPort sendPort;
  ReceivePort receivePort;

  StreamSubscription handle;

  final timeout = const Duration(milliseconds: 2);

  LoggingHandler(this.sendPort) {
    new InitiationDispatcher()
      ..registerHandler(this, 'log')
      ..registerHandler(this, 'log_close');

    receivePort = new ReceivePort();
    sendPort.send(receivePort.sendPort);

    handle = receivePort.
      asBroadcastStream().
      timeout(timeout, onTimeout: (_){ handle.pause(); }).
      listen(write)
      ..pause();
  }

  void handleEvent(event) {
    if (event.type == 'log') {
      read();
    }
    else if (event.type == 'log_close') {
      handle.cancel();
      receivePort.close();
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
