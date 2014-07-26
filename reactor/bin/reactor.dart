#!/usr/bin/env dart

import 'package:reactor_code/reactor.dart';

main() {
  // Create (and register in constructor) event handler
  new HandleKey();

  // Reactor loop...
  for(;;) {
    new InitiationDispatcher().handleEvents();
  }
}
