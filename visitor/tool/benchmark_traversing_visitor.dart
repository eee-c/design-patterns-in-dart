#!/usr/bin/env dart

import 'package:benchmark_harness/benchmark_harness.dart';

import 'package:visitor_code/traversing_visitor.dart';

var visitor, nodes;

_setup(){
  visitor = new PricingVisitor();

  nodes = new InventoryCollection([mobile(), tablet(), laptop()]);
  for (var i=0; i<1000; i++) {
    nodes.stuff[0].apps.add(app('Mobile App $i', price: i));
  }
  for (var i=0; i<100; i++) {
    nodes.stuff[1].apps.add(app('Tablet App $i', price: i));
  }
}

class TraversingVisitorBenchmark extends BenchmarkBase {
  const TraversingVisitorBenchmark() : super("Visitor Traverses");
  static void main() { new TraversingVisitorBenchmark().report(); }

  void run() {
    nodes.accept(visitor);
    // print('Cost of work stuff: ${visitor.totalPrice}.');
  }
}

main () {
  _setup();

  TraversingVisitorBenchmark.main();
  TraversingVisitorBenchmark.main();
}
