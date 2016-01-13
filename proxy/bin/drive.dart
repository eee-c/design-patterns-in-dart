#!/usr/bin/env dart

import 'dart:isolate';

import 'package:proxy_code/car.dart';

main() {
  var r = new ReceivePort();
  var receiveStream = r.asBroadcastStream();

  ProxyCar car;

  Isolate.
    spawn(other, r.sendPort).

    // Wait for isolate to be ready, then return first message, which is send
    // port back to the isolate
    then((_) => receiveStream.first).

    // Create proxy car with receive stream and isolate send port
    then((s) { car = new ProxyCar(receiveStream, s); }).

    // Drive proxy car, then wait for state message
    then((_) { car.drive(); }).
    then((_) => receiveStream.first).

    // Proxy car state is ready, so print
    then((_) { print("Car is ${car.state}"); }).

    // Stop proxy car, then wait for state message
    then((_) { car.stop(); }).
    then((_) => receiveStream.first).

    // Proxy car state is ready, so print
    then((_) { print("Car is ${car.state}"); });

}

other(SendPort s) {
  var r = new ReceivePort();
  var receiveStream = r.asBroadcastStream();
  s.send(r.sendPort);

  new Car(receiveStream, s);
}
