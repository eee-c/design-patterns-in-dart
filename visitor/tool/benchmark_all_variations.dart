#!/usr/bin/env dart

import 'package:benchmark_harness/benchmark_harness.dart';

import 'package:visitor_code/visitor.dart';
import 'package:visitor_code/inventory.dart' as i2;
import 'package:visitor_code/inventory_single_dispatch.dart' as i1;

var visitor, nodes2, nodes1;

_setup(){
  // Visitor
  visitor = new PricingVisitor();

  // Single-dispatching iterators
  nodes1 = new i1.InventoryCollection([
    i1.mobile(), i1.tablet(), i1.laptop()
  ]);
  for (var i=0; i<1000; i++) {
    nodes1.stuff[0].apps.add(i1.app('Mobile App $i', price: i));
  }
  for (var i=0; i<100; i++) {
    nodes1.stuff[1].apps.add(i1.app('Tablet App $i', price: i));
  }

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

class NodesSingleBenchmark extends BenchmarkBase {
  const NodesSingleBenchmark() : super("Nodes iterate w/ single dispatch ");
  static void main() { new NodesSingleBenchmark().report(); }

  void run() {
    nodes1.accept(visitor);
    // print('Cost of work stuff: ${visitor.totalPrice}.');
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

  NodesSingleBenchmark.main();
  NodesDoubleBenchmark.main();
  print('--');
  NodesSingleBenchmark.main();
  NodesDoubleBenchmark.main();
}
