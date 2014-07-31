part of reactor;

class InitiationDispatcher implements Dispatcher {
  var events = {};

  static final InitiationDispatcher _dispatcher =
    new InitiationDispatcher._internal();
  factory InitiationDispatcher()=> _dispatcher;
  InitiationDispatcher._internal();

  registerHandler(eventHandler, eventType) {
    events.putIfAbsent(eventType, ()=> []);
    events[eventType].add(eventHandler);
  }

  removeHandler(eventHandler, eventType) { }

  handleEvents() {
    var event = select();
    if (event == null) return;

    print('[handleEvents] ${event.type}');
    events[event.type].forEach((h)=> h.handleEvent(event));
  }
}
