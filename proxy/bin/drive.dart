#!/usr/bin/env dart

import 'dart:isolate';

import 'package:proxy_code/car.dart';

main() async {
  // Create proxy car
  ProxyCar car = new ProxyCar();

  await Isolate.spawn(other, car.sendPort);

  await car.ready;

  // Drive proxy car, then wait for state message
  await car.drive();

  // Proxy car state is ready, so print
  print("Car is ${car.state}");

  print("--");

  // Stop proxy car, then wait for state message
  await car.stop();

  // Proxy car state is ready, so print
  print("Car is ${await car.state}");
}

other(SendPort s) {
  var r = new ReceivePort();
  s.send(r.sendPort);

  new AsyncCar(r, s);
}
