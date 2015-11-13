#!/usr/bin/env dart

import 'package:flyweight_code/flyweight_tree.dart';

main() {
  var tree = new Tree()
    ..hang_lamp('red', 1)
    ..hang_lamp('blue', 1)
    ..hang_lamp('yellow', 1)
    ..hang_lamp('red', 2)
    ..hang_lamp('blue', 2)
    ..hang_lamp('yellow', 2)
    ..hang_lamp('red', 3)
    ..hang_lamp('blue', 3)
    ..hang_lamp('yellow', 3)
    ..hang_lamp('red', 4)
    ..hang_lamp('blue', 4)
    ..hang_lamp('yellow', 4)
    ..hang_lamp('red', 5)
    ..hang_lamp('blue', 5)
    ..hang_lamp('yellow', 5)
    ..hang_lamp('red', 6)
    ..hang_lamp('blue', 6)
    ..hang_lamp('yellow', 6)
    ..hang_lamp('red', 7)
    ..hang_lamp('blue', 7)
    ..hang_lamp('yellow', 7);

  print(tree.report);
}
