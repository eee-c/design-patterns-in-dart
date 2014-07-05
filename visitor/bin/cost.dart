#!/usr/bin/env dart

import 'package:visitor_code/visitor.dart';
import 'package:visitor_code/equipment.dart';

main() {
  var cost = new PricingVisitor();

  var work_stuff = [
    new Mobile(),
    new Tablet(),
    new Laptop()
  ];

  work_stuff.forEach((e){ e.accept(cost); });

  print('Cost of work stuff: ${cost.totalPrice}.');
}
