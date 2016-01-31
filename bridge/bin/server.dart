#!/usr/bin/env dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http_server/http_server.dart';

main() {
  var staticFiles = new VirtualDirectory('web');
  _enableIndexHandling(staticFiles);

  runZoned(() async {
    var server = await HttpServer.bind('localhost', 4040);
    await for (var req in server) {
      if (req.uri.path == '/ws')
        establishWebSocket(req);
      else if (req.uri.path == '/save' && req.method == 'POST')
        save(req);
      else
        staticFiles.serveRequest(req);
    }
  },
  onError: (e) => print("An error occurred: $e"));
}

establishWebSocket(req) async {
  var socket = await WebSocketTransformer.upgrade(req);

  socket.listen((message) {
    print("[WebSocket] $message");
  });
}

save(req) async {
  var message = await req.transform(UTF8.decoder).join();
  print("[HTTP] $message");
}

_enableIndexHandling(VirtualDirectory vDir) {
  vDir
    ..allowDirectoryListing = true
    ..directoryHandler = (dir, request) {
        var indexUri = new Uri.file(dir.path).resolve('index.html');
        vDir.serveFile(new File(indexUri.toFilePath()), request);
      };
}
