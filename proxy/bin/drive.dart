#!/usr/bin/env dart

import 'package:proxy_code/car.dart';

main() {
  Driver driver;

  // Proxy will allow access to real subject
  driver = new Driver(25);
  print("== $driver here:");
  new ProxyAutomobile(#Car,        driver)..drive();
  new ProxyAutomobile(#Truck,      driver)..drive();
  new ProxyAutomobile(#Motorcycle, driver)..drive();

  print('');

  // Proxy will deny access to real subject
  driver = new Driver(16);
  print("== $driver here:");
  new ProxyAutomobile(#Car, new Driver(16))..drive();
  print('');
}
