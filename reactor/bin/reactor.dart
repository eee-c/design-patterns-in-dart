#!/usr/bin/env dart

import 'dart:async';
import 'package:reactor_code/reactor.dart';

main() {
  _startRandomMessageSender();

  // Create (and register in constructor) event handler
  new WordAcceptor();

  // Reactor loop...
  for(;;) {
    new InitiationDispatcher().handleEvents();
  }
}

void _startRandomMessageSender() {

      var words = ['one', 'two', 'three'];
      var controller = new StreamController();
      controller.add('one');
      var handle = new Handle('word', controller.stream);
      select().add(new SystemEvent('word', handle.number));
      print('yo');
      controller.add('one');


  new Timer(
    new Duration(seconds: 1),
    () {
      print('Time!!!');


      print('one');
      controller.add('one');
      print('two');
      controller.add('two');
      print('three');
      controller.add('three');


    }
  );
}
