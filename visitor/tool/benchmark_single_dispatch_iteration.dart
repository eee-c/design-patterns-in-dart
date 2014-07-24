#!/usr/bin/env dart

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:dpid_benchmarking/config.dart';
import 'package:dpid_benchmarking/score_emitters.dart';

import 'package:visitor_code/alt/single_dispatch_iteration/visitor.dart';

const String NAME = "Nodes iterate w/ single dispatch";

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


int loopSize, numberOfRuns;

main (List<String> args) {
  var conf = new Config(args);
  loopSize = conf.loopSize;
  numberOfRuns = conf.numberOfRuns;
  List<double> results = new List(numberOfRuns);

  _setup();
  for (var i=0; i<=numberOfRuns; i++) {
    double score = PatternBenchmark.main();
    if (i == 0) continue; // Ignore first run (extra warm up)
    results[i-1] = score;
  }
  recordTsvTotal(NAME, results, loopSize, numberOfRuns);
}

class PatternBenchmark extends BenchmarkBase {
  const PatternBenchmark(): super(NAME);

  static double main()=> new PatternBenchmark().measure();

  void run() { _run(loopSize); }
}
