#!/usr/bin/env dart

import 'dart:isolate';

import 'package:proxy_code/car.dart';

main() async {
  var mainIn = new ReceivePort();
  await Isolate.spawn(worker, mainIn.sendPort);

  var inStream = mainIn.asBroadcastStream();
  SendPort mainOut = await inStream.first;

  // Create proxy car with receive stream and isolate send port
  ProxyCar car = new ProxyCar(inStream, mainOut);

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

worker(SendPort workerOut) {
  var workerIn = new ReceivePort();
  workerOut.send(workerIn.sendPort);

  var inStream = workerIn.asBroadcastStream();
  new AsyncCar(inStream, workerOut);
}
