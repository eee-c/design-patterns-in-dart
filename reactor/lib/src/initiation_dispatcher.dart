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
    connect().
      stream.
      listen((event){
        print('[handleEvents] ${event["type"]}');
        events[event['type']].forEach((h)=> h.handleEvent(event));
      });
    new Timer(new Duration(seconds: 20), (){});
  }
}
