#!/usr/bin/env dart

import 'dart:isolate';

import 'package:proxy_code/car.dart';

main() async {
  var r = new ReceivePort();
  var receiveStream = r.asBroadcastStream();

  await Isolate.spawn(other, r.sendPort);

  SendPort s = await receiveStream.first;

  // Create proxy car with receive stream and isolate send port
  ProxyCar car = new ProxyCar(receiveStream, s);

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
  var receiveStream = r.asBroadcastStream();
  s.send(r.sendPort);

  new AsyncCar(receiveStream, s);
}
