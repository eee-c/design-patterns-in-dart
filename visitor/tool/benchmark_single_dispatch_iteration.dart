#!/usr/bin/env dart

import 'package:benchmark_harness/benchmark_harness.dart';

import 'package:visitor_code/alt/single_dispatch_iteration/visitor.dart';

main () {
  _setup();

  NodesSingleBenchmark.main();
  NodesSingleBenchmark.main();
  NodesSingleBenchmark.main();
}

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

class NodesSingleBenchmark extends BenchmarkBase {
  const NodesSingleBenchmark() :
    super(
      "Nodes iterate w/ single dispatch",
      emitter: const ProperPrecisionScoreEmitter()
    );

  static void main() { new NodesSingleBenchmark().report(); }

  void run() {
    for (var i=0; i<10; i++) {
      visitor.totalPrice = 0.0;
      nodes.accept(visitor);
    }
  }
}

class ProperPrecisionScoreEmitter implements ScoreEmitter {
  const ProperPrecisionScoreEmitter();

  void emit(String testName, double value) {
    print("$testName (RunTime): ${value.toStringAsPrecision(4)} µs.");
  }
}
