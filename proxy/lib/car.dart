library car;

import 'dart:mirrors' show reflect;

// Subject
abstract class Automobile {
  void drive();
}

class IllegalAutomobileActionException implements Exception {
  Symbol message;
  IllegalAutomobileActionException(this.message);
  toString() => "IllegalAutomobileActionException: $message";
}

// Real Subject
class Car implements Automobile {
  void drive() {
    print("Car has been driven!");
  }
}

// Proxy Subject
class ProxyProtect {
  final Driver _driver;
  final _realSubject;

  ProxyProtect(this._driver, this._realSubject);

  dynamic noSuchMethod(i) {
    if (i.memberName != #drive)
      throw new IllegalAutomobileActionException(i.memberName);
    if (_driver.age <= 16)
      throw new IllegalDriverException(_driver, "too young");

    return reflect(_realSubject).delegate(i);
  }
}

class Driver {
  int age;
  Driver(this.age);
  toString() => "$age year-old driver";
}

class IllegalDriverException implements Exception {
  Driver driver;
  String message;
  IllegalDriverException(this.driver, this.message);
  toString() => "IllegalDriverException: $driver is $message!";
}
