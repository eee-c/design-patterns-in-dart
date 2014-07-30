part of reactor;

StreamController _connect;
connect() {
  if (_connect == null) {
    _connect = new StreamController.broadcast();
  }
  return _connect;
}
