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

  ProxyCar(this._driver) {
    _car = new Car();
  }

  void drive() {
    if (_driver.age <= 16) {
      print("Sorry, the driver is too young to drive.");
      return;
    }

    _car.drive();
  }
}

class Driver {
  int age;
  Driver(this.age);
}
