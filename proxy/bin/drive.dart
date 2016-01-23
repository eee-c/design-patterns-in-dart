#!/usr/bin/env dart

import 'package:proxy_code/car.dart';

import 'dart:async';

main() async {
  var socket = new StreamController.broadcast();

  // Create proxy car with send/receive streams
  ProxyCar car = new ProxyCar(socket);

  // Start "worker"
  worker(socket);

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

worker(StreamController socket) {
  new AsyncCar(socket);
}
