part of reactor;

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
    var event = select().fetch();
    if (event == null) return;
    print(event.type);
    events[event.type].forEach((h)=> h.handleEvent(event));
  }
}
