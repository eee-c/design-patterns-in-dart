part of reactor;

class StdinDispatcher {
  var events = {};

  static final StdinDispatcher _dispatcher =
    new StdinDispatcher._internal();

  factory StdinDispatcher() {
    return _dispatcher;
  }

  StdinDispatcher._internal() {
    stdin.echoMode = false;
  }

  registerHandler(eventHandler, eventType) {
    events.putIfAbsent(eventType, ()=> []);
    events[eventType].add(eventHandler);
  }

  removeHandler(eventHandler, eventType) { }

  handleEvents([int timeout=0]) {
    var line = stdin.readLineSync();
    print('NOTIFIED! I\'m blocking now for reactor events...');
    events['key'].forEach((h)=> h.handleEvent('key'));
  }
}
