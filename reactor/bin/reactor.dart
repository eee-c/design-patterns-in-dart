#!/usr/bin/env dart

import 'dart:async';
import 'package:reactor_code/reactor.dart';

// ReceivePort => StreamController
// sendPort => stream

main() {
  // Start the message sender and set its connection as the source of
  // the fake select() messages
  messageSender(connect());

  // Create (and register in constructor) event handler
  new LoggingAcceptor();

  // Reactor “loop” (handleEvent is recursive)
  new InitiationDispatcher().handleEvents();

  // NOTREACHED
  return 0;
}

void messageSender(StreamController server) {
  var logClient = new StreamController();
  server.add({'type': 'log_connect', 'value': logClient});
  logClient.
    stream.
    first.
    then((StreamController s1) {
      s1.add({'type': 'log', 'value': 'howdy'});
      s1.add({'type': 'log', 'value': 'chris'});
      server.add({'type': 'log'});

      new Timer(
        new Duration(seconds: 2),
        (){
          s1.add({'type': 'log', 'value': 'delayed'});
          s1.add({'type': 'log', 'value': 'howdy'});
          s1.add({'type': 'log', 'value': 'chris'});
          server.add({'type': 'log'});

          new Timer(
            new Duration(seconds: 2),
            (){
              server.add({'type': 'log_close'});
              logClient.close();
            }
          );
        }
      );
    });
}
