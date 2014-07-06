#!/usr/bin/env dart

import 'package:visitor_code/visitor.dart';
import 'package:visitor_code/inventory.dart';

main() {
  var work_stuff = [
    new Mobile()
      ..apps = [
          new App('2048')..netPrice = 10.0,
          new App('Pixel Dungeon')..netPrice = 7.0,
          new App('Monument Valley')..netPrice = 4.0
        ],
    new Tablet()
      ..apps = [
          new App('Angry Birds Tablet Platinum Edition')..netPrice = 1000.0
        ],
    new Laptop()
  ];


  var cost = new PricingVisitor();
  work_stuff.forEach((e){ e.accept(cost); });
  print('Cost of work stuff: ${cost.totalPrice}.');
}
