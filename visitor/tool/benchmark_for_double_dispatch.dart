#!/usr/bin/env dart

import 'package:benchmark_harness/benchmark_harness.dart';

import 'package:visitor_code/visitor.dart';
import 'package:visitor_code/inventory.dart' as i2;

var visitor, nodes2;

_setup(){
  // Visitor
  visitor = new PricingVisitor();

  // Double-dispatching iterators
  nodes2 = new i2.InventoryCollection([
    i2.mobile(), i2.tablet(), i2.laptop()
  ]);
  for (var i=0; i<1000; i++) {
    nodes2.stuff[0].apps.add(i2.app('Mobile App $i', price: i));
  }
  for (var i=0; i<100; i++) {
    nodes2.stuff[1].apps.add(i2.app('Tablet App $i', price: i));
  }
}

class NodesDoubleBenchmark extends BenchmarkBase {
  const NodesDoubleBenchmark() : super("Nodes iterate w/ double dispatch ");
  static void main() { new NodesDoubleBenchmark().report(); }

  void run() {
    nodes2.accept(visitor);
    // print('Cost of work stuff: ${visitor.totalPrice}.');
  }
}

main () {
  _setup();

  NodesDoubleBenchmark.main();
  NodesDoubleBenchmark.main();
}
