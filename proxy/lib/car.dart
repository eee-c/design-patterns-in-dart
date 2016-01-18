library car;

import 'dart:mirrors';

// Subject
abstract class Automobile {
  void drive();
}

// Real Subjects
class Car implements Automobile {
  void drive() {
    print("Car has been driven!");
  }
}

class Truck implements Automobile {
  void drive() {
    print("Truck has been driven!");
  }
}

class Motorcycle implements Automobile {
  void drive() {
    print("Motorcycle has been driven!");
  }
}

// Proxy Subject
class ProxyAutomobile implements Automobile {
  Driver _driver;
  Symbol _autoType;

  ProxyAutomobile(this._autoType, this._driver);

  Automobile get auto => _autoMirror.reflectee;

  InstanceMirror get _autoMirror =>
    _classMirror.newInstance(new Symbol(''), []);

  ClassMirror get _classMirror =>
    currentMirrorSystem().
      findLibrary(#car).
      declarations[_autoType];

  void drive() {
    if (_driver.age <= 16)
      throw new IllegalDriverException(_driver, "too young");

    auto.drive();
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
