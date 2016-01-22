#!/usr/bin/env dart

import 'dart:async';
import 'dart:io';

import 'package:proxy_code/car.dart';

main() {
  runZoned(() async {
    var server = await HttpServer.bind('localhost', 4040);
    await for (var req in server) {
      if (req.uri.path == '/ws') {
        // Upgrade a HttpRequest to a WebSocket connection.
        var socket = await WebSocketTransformer.upgrade(req);
        new AsyncCar(socket);
      };
    }
  },
  onError: (e) => print("An error occurred: $e"));
}
