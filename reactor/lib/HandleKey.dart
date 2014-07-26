import 'dart:io';
import 'InitiationDispatcher.dart';

class HandleKey {
  HandleKey(){
    new InitiationDispatcher().registerHandler(this, 'key');
  }

  handleEvent(eventType) {
    if (eventType == 'key') {
      print('[handleEvent] $handle');
    }
  }

  get handle {
    return stdin.readLineSync();
  }
}
