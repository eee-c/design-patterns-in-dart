library car;

import 'dart:async' show Future;

abstract class Automobile {
  String get state;
  void drive();
  void stop();
}

// Subject
abstract class AsyncAuto implements Automobile {
  String get state;
  Future drive();
  Future stop();
}
