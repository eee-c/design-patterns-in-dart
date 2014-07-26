#!/usr/bin/env dart

import 'package:reactor_code/reactor.dart';

main() {
  new HandleKey();

  for(;;) {
    new InitiationDispatcher().handleEvents();
  }

}
