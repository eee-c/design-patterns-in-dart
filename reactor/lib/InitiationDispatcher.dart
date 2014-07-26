import 'dart:io';

class InitiationDispatcher {
  var events = {};

  static final InitiationDispatcher _dispatcher =
    new InitiationDispatcher._internal();

  factory InitiationDispatcher() {
    return _dispatcher;
  }

  InitiationDispatcher._internal() {
    stdin.echoMode = false;
  }

  registerHandler(eventHandler, eventType) {
    events.putIfAbsent(eventType, ()=> []);
    events[eventType].add(eventHandler);
  }

  removeHandler(eventHandler, eventType) { }

  handleEvents([int timeout=0]) {
    var line = stdin.readLineSync();
    print('[handleEvents] $line');
    events['key'].forEach((h)=> h.handleEvent('key'));
  }
}
