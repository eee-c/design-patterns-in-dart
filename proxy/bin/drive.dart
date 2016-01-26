#!/usr/bin/env dart

import 'package:proxy_code/car.dart';

main() {
  drive25();
  print('');

  drive16();
  print('');
}

drive25() {
  var _car = new Car(),
      _driver = new Driver(25);
  print("* $_driver here:");

  var car = new ProxyProtect(_driver, _car);
  car.drive();
}

drive16() {
  var _car = new Car(),
      _driver = new Driver(16);
  print("* $_driver here:");

  var car = new ProxyProtect(_driver, _car);
  car.drive();
}
