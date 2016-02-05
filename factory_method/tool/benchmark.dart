#!/usr/bin/env dart

import 'package:dpid_benchmarking/pattern_benchmark.dart';

import 'package:factory_method_code/alt/classic/factory_method.dart';

main(List<String> args) {
  BenchmarkRunner.main(
    args,
    "Classic subclass",
    (){},
    (loopSize) {
      for (var i=0; i<loopSize; i++) {
        new ConcreteCreator().productMaker();
      }
    }
  );
}
