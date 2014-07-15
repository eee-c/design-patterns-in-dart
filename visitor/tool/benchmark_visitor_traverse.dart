#!/usr/bin/env dart

import 'package:benchmark_harness/benchmark_harness.dart';
import 'src/config.dart';
import 'src/proper_precision_score_emitter.dart';

import 'package:visitor_code/alt/visitor_traverse/visitor.dart';

var visitor, nodes;
int loopSize, numberOfRuns;

main (List<String> args) {
  var conf = new Config(args);
  loopSize = conf.loopSize;
  numberOfRuns = conf.numberOfRuns;

  _setup();
  for (var i=0; i<numberOfRuns; i++) {
    TraversingVisitorBenchmark.main();
  }
}

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
  const TraversingVisitorBenchmark() :
    super(
      "Visitor Traverses",
      emitter: const ProperPrecisionScoreEmitter()
    );

  static void main() { new TraversingVisitorBenchmark().report(); }

  void run() {
    for (var i=0; i<loopSize; i++) {
      visitor.totalPrice = 0.0;
      nodes.accept(visitor);
    }
  }
}
