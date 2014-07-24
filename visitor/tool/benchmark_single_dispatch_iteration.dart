#!/usr/bin/env dart

import 'package:dpid_benchmarking/pattern_benchmark.dart';

import 'package:visitor_code/alt/single_dispatch_iteration/visitor.dart';

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
    "Nodes iterate w/ single dispatch",
    Setup.setup,
    Setup.run
  );
}
