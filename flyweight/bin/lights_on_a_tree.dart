#!/usr/bin/env dart

import 'package:flyweight_code/flyweight_tree.dart';

main() {
  var tree = new Tree()
    ..hangLamp('red', 1)
    ..hangLamp('blue', 1)
    ..hangLamp('yellow', 1)
    ..hangLamp('red', 2)
    ..hangLamp('blue', 2)
    ..hangLamp('yellow', 2)
    ..hangLamp('red', 3)
    ..hangLamp('blue', 3)
    ..hangLamp('yellow', 3)
    ..hangLamp('red', 4)
    ..hangLamp('blue', 4)
    ..hangLamp('yellow', 4)
    ..hangLamp('red', 5)
    ..hangLamp('blue', 5)
    ..hangLamp('yellow', 5)
    ..hangLamp('red', 6)
    ..hangLamp('blue', 6)
    ..hangLamp('yellow', 6)
    ..hangLamp('red', 7)
    ..hangLamp('blue', 7)
    ..hangLamp('yellow', 7);

  print(tree.report);
}
