#!/usr/bin/env dart

import 'package:reactor_code/InitiationDispatcher.dart';
import 'package:reactor_code/HandleKey.dart';

main() {

  new HandleKey();

  for(;;) {
    new InitiationDispatcher().handleEvents();
  }

}
