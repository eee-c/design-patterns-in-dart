library car;

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
  Automobile _auto;

  ProxyAutomobile(this._auto, this._driver);

  void drive() {
    if (_driver.age <= 16)
      throw new IllegalDriverException(_driver, "too young");

    _auto.drive();
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
