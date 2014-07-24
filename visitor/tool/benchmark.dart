#!/usr/bin/env dart

import 'package:dpid_benchmarking/pattern_benchmark.dart';

import 'package:visitor_code/visitor.dart';

import '_setup.dart' as Setup;

main(List<String> args) {
  Setup.visitorMaker = ()=> new PricingVisitor();
  Setup.inventoryCollectionMaker = (items) => new InventoryCollection(items);
  Setup.mobile = mobile;
  Setup.tablet = tablet;
  Setup.laptop = laptop;
  Setup.app = app;

  BenchmarkRunner.main(
    args,
    "Classic Visitor Pattern",
    Setup.setup,
    Setup.run
  );
}
