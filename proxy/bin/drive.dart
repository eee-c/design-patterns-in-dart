#!/usr/bin/env dart

import 'dart:io' show WebSocket;

import 'package:proxy_code/car.dart';

main() async {
  var socket = await WebSocket.connect('ws://localhost:4040/ws');

  // Create proxy car with send/receive streams
  ProxyCar car = new ProxyCar(socket);

  // Drive proxy car, then wait for state message
  print("Attempting to drive remote car...");
  await car.drive();

  // Proxy car state is ready, so print
  print("Car is ${car.state}");

  print("--");

  // Stop proxy car, then wait for state message
  print("Attempting to stop remote car...");
  await car.stop();

  // Proxy car state is ready, so print
  print("Car is ${await car.state}");
}
