#!/usr/bin/env dart

import 'dart:async';
import 'dart:isolate';
import 'package:reactor_code/reactor.dart';

main() {
  // Spawn the message sending isolate and set its receive port as the source of
  // the fake select() messages
  var res = new ReceivePort();
  Select.source = res;
  Isolate.spawn(messageSender, res.sendPort);

  // Create (and register in constructor) event handler
  new WordAcceptor();

  // Reactor “loop” (handleEvent is recursive)
  new InitiationDispatcher().handleEvents();

  // NOTREACHED
  return 0;
}

void messageSender(SendPort port) {
  var wordSender = new ReceivePort();
  port.send({'type': 'word_connect', 'value': wordSender.sendPort});
  wordSender.
    first.
    then((SendPort s1) {
      s1.send({'type': 'word', 'value': 'howdy'});
      s1.send({'type': 'word', 'value': 'chris'});
      port.send({'type': 'word'});

      new Timer(
        new Duration(seconds: 2),
        (){
          s1.send({'type': 'word', 'value': 'delayed'});
          s1.send({'type': 'word', 'value': 'howdy'});
          s1.send({'type': 'word', 'value': 'chris'});
          port.send({'type': 'word'});


          new Timer(
            new Duration(seconds: 2),
            (){
              port.send({'type': 'word_close'});
              wordSender.close();
            }
          );

        }
      );
    });
}
