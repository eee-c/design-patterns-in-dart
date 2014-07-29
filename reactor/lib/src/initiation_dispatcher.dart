part of reactor;

class InitiationDispatcher implements Dispatcher {
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
    if (event == null) {
      Timer.run((){this.handleEvents();});
      return;
    }
    print('[handleEvents] ${event.type}');
    events[event.type].forEach((h)=> h.handleEvent(event));
    this.handleEvents();
  }
}
