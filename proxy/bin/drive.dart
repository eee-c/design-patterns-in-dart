#!/usr/bin/env dart

import 'package:proxy_code/car.dart';

main() {
  Driver driver;

  // Proxy will allow access to real subject
  driver = new Driver(25);
  print("== $driver here:");
  new ProxyAutomobile(new Car(),        driver)..drive();
  new ProxyAutomobile(new Truck(),      driver)..drive();
  new ProxyAutomobile(new Motorcycle(), driver)..drive();

  print('');

  // Proxy will deny access to real subject
  driver = new Driver(16);
  print("== $driver here:");
  new ProxyAutomobile(new Car(), new Driver(16))..drive();
  print('');
}
