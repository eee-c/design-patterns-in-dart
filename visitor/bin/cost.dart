#!/usr/bin/env dart

import 'package:visitor_code/visitor.dart';
import 'package:visitor_code/inventory.dart';

main() {
  var work_stuff = new InventoryCollection([
    mobile()..apps = [
      app('2048', price: 10.0),
      app('Pixel Dungeon', price: 7.0),
      app('Monument Valley', price: 4.0)
    ],
    tablet()..apps = [
      app('Angry Birds Tablet Platinum Edition', price: 1000.0)
    ],
    laptop()
  ]);

  var cost = new PricingVisitor();
  work_stuff.accept(cost);
  print('Cost of work stuff: ${cost.totalPrice}.');

  var counter = new TypeCountVisitor();
  work_stuff.accept(counter);
  print('I have ${counter.apps} apps!');
}
