library pattern_benchmark;

import 'package:benchmark_harness/benchmark_harness.dart';

import 'config.dart';
import 'score_emitters.dart';

int loopSize, numberOfRuns;
var setup, benchmark;

class BenchmarkRunner {
  static main (List<String> args, name, _setup, _run) {
    var conf = new Config(args);
    loopSize = conf.loopSize;
    numberOfRuns = conf.numberOfRuns;

    setup = _setup;
    benchmark = _run;

    List<double> results = new List(numberOfRuns);

    setup();
    for (var i=0; i<=numberOfRuns; i++) {
      double score = PatternBenchmark.main();
      if (i == 0) continue; // Ignore first run (extra warm up)
      results[i-1] = score;
    }
    recordTsvTotal(name, results, loopSize, numberOfRuns);
  }
}

class PatternBenchmark extends BenchmarkBase {
  const PatternBenchmark(): super("Pattern Benchmark");

  static double main()=> new PatternBenchmark().measure();

  void run() { benchmark(loopSize); }
}
