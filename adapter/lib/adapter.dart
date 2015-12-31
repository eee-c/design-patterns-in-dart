library adapter;

import 'adaptee.dart';

class Target {
  void request() {
    print("[Target] A request.");
  }
}

class Adapter implements Target {
  Adaptee _adaptee;

  Adapter(this._adaptee);

  void request() {
    print("[Adapter] doing stuff..");
    _adaptee.specificRequest();
  }
}
