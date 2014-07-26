part of reactor;

class HandleKey {
  HandleKey(){
    new StdinDispatcher().registerHandler(this, 'key');
  }

  handleEvent(eventType) {
    if (eventType == 'key') {
      print('[handleEvent] $handle');
    }
  }

  get handle {
    return stdin.readLineSync();
  }
}
