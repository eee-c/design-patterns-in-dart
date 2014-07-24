#!/usr/bin/env dart

import 'package:dpid_benchmarking/pattern_benchmark.dart';

import 'package:visitor_code/alt/visitor_traverse/visitor.dart';

main(List<String> args) {
  BenchmarkRunner.main(
    args,
    "Visitor Traverses",
    _setup,
    _run
  );
}


var visitor, nodes;

_setup() {
  visitor = new PricingVisitor();

  nodes = new InventoryCollection([mobile(), tablet(), laptop()]);
  for (var i=0; i<1000; i++) {
    nodes.stuff[0].apps.add(app('Mobile App $i', price: i));
  }
  for (var i=0; i<100; i++) {
    nodes.stuff[1].apps.add(app('Tablet App $i', price: i));
  }
}

_run(loopSize) {
  for (var i=0; i<loopSize; i++) {
    visitor.totalPrice = 0.0;
    nodes.accept(visitor);
  }
}
