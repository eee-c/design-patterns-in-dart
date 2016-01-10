#!/usr/bin/env dart

import 'package:proxy_code/car.dart';

main() {
  Automobile car;

  // Proxy will deny access to real subject
  print("* 16 year-old drive here:");
  car = new ProxyCar(new Driver(16));
  car.drive();
  print('');

  // Proxy will allow access to real subject
  print("* 25 year-old drive here:");
  car = new ProxyCar(new Driver(25));
  car.drive();
  print('');
}
