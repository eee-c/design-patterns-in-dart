library car;

// Subject
abstract class Automobile {
  void drive();
}


// Real Subject
class Car implements Automobile {
  void drive() {
    print("Car has been driven!");
  }
}

// Proxy Subject
class ProxyCar implements Automobile {
  Driver _driver;
  Car _car;

  ProxyCar(this._driver);

  Car get car => _car ??= new Car();

  void drive() {
    if (_driver.age <= 16)
      throw new IllegalDriverException(_driver, "too young");

    car.drive();
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
