part of reactor;

class WordAcceptor implements EventHandler {
  WordAcceptor() {
    new InitiationDispatcher().registerHandler(this, 'word_connect');
  }

  void handleEvent(connection) {
    if (connection.type != 'word_connect') return;
    new WordPrinter(connection.value);
  }
}

class WordPrinter implements EventHandler {
  SendPort sendPort;
  ReceivePort receivePort;

  StreamSubscription handle;

  final timeout = const Duration(milliseconds: 2);

  WordPrinter(this.sendPort) {
    new InitiationDispatcher()
      ..registerHandler(this, 'word')
      ..registerHandler(this, 'word_close');

    receivePort = new ReceivePort();
    sendPort.send(receivePort.sendPort);

    handle = receivePort.
      asBroadcastStream().
      timeout(timeout, onTimeout: (_){ handle.pause(); }).
      listen(write)
      ..pause();
  }

  void handleEvent(event) {
    if (event.type == 'word') {
      read();
    }
    else if (event.type == 'word_close') {
      handle.cancel();
      receivePort.close();
      new InitiationDispatcher()
        ..removeHandler(this, 'word')
        ..removeHandler(this, 'word_close');
    }
  }

  void read() {
    handle.resume();
  }

  void write(word) {
    print('[WordPrinter.read] $word');
  }
}
