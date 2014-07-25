#!/usr/bin/env dart

import 'package:dpid_benchmarking/pattern_benchmark.dart';

import 'package:factory_method_code/alt/mirrors/factory_method.dart';

main(List<String> args) {
  BenchmarkRunner.main(
    args,
    "Mirrors",
    (){},
    (loopSize) {
      for (var i=0; i<loopSize; i++) {
        new ConcreteCreator().productMaker();
      }
    }
  );
}
