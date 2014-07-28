part of reactor;

class WordAcceptor implements EventHandler {
  WordAcceptor() {
    new InitiationDispatcher().registerHandler(this, 'word');
  }

  void handleEvent(event) {
    if (event.type != 'word') return;
    new WordPrinter(event.handleId);
  }
  get handle;
}

class WordPrinter  {
  int handleId;
  Handle handle;

  WordPrinter(this.handleId) {
    handle = Handle.lookup[handleId];
    read();
  }

  void read() {
    print(handle.stream);
    handle.stream.listen((word){
      print('[WordPrinter.read] $word');
    });
  }
}
