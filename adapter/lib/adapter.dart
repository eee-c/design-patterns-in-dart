library adapter;

import 'adaptee.dart';

class Target {
  void request() {
    print("[Target] A request.");
  }
}

class Adapter extends Adaptee implements Target {
  void request() {
    print("[Adapter] doing stuff..");
    specificRequest();
  }
}
