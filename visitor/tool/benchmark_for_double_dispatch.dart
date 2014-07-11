#!/usr/bin/env dart

import 'package:benchmark_harness/benchmark_harness.dart';

import 'package:visitor_code/visitor.dart';

main () {
  _setup();

  NodesDoubleBenchmark.main();
  NodesDoubleBenchmark.main();
  NodesDoubleBenchmark.main();
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

class NodesDoubleBenchmark extends BenchmarkBase {
  const NodesDoubleBenchmark() :
    super(
      "Nodes iterate w/ double dispatch",
      emitter: const ProperPrecisionScoreEmitter()
    );
  static void main() { new NodesDoubleBenchmark().report(); }

  void run() {
    for (var i=0; i<10^6; i++) {
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
