#!/usr/bin/env dart

import 'dart:async';
import 'dart:isolate';
import 'package:reactor_code/reactor.dart';

main() {
  // Spawn the message sending isolate and set its receive port as the source of
  // the fake select() messages
  Isolate.spawn(messageSender, connection());

  // Create (and register in constructor) event handler
  new LoggingAcceptor();

  // Reactor “loop” (handleEvent is recursive)
  new InitiationDispatcher().handleEvents();

  // NOTREACHED
  return 0;
}

void messageSender(SendPort server) {
  var logClient = new ReceivePort();
  server.send({'type': 'log_connect', 'value': logClient.sendPort});
  logClient.
    first.
    then((SendPort s1) {
      s1.send({'type': 'log', 'value': 'howdy'});
      s1.send({'type': 'log', 'value': 'chris'});
      server.send({'type': 'log'});

      new Timer(
        new Duration(seconds: 2),
        (){
          s1.send({'type': 'log', 'value': 'delayed'});
          s1.send({'type': 'log', 'value': 'howdy'});
          s1.send({'type': 'log', 'value': 'chris'});
          server.send({'type': 'log'});


          new Timer(
            new Duration(seconds: 2),
            (){
              server.send({'type': 'log_close'});
              logClient.close();
            }
          );

        }
      );
    });
}
