part of reactor;

abstract class Dispatcher {
  void handleEvents([int timeout=0]);
  void registerHandler(EventHandler);
  void removeHandler(EventHandler);
}

abstract class EventHandler {
  void handleEvent(type);
  get handle;
}
