import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:factory_method_code/alt/classic/factory_method.dart' as Subclass;
import 'package:factory_method_code/alt/map_of_factories/factory_method.dart' as MapOfFactories;
import 'package:factory_method_code/alt/mirrors/factory_method.dart' as Mirrors;

class FactoryMethodSubclassBenchmark extends BenchmarkBase {
  const FactoryMethodSubclassBenchmark() : super("Factory Method — Subclass");

  static void main() {
    new FactoryMethodSubclassBenchmark().report();
  }

  // Not measured setup code executed prior to the benchmark runs.
  void setup() { }

  // Not measures teardown code executed after the benchark runs.
  void teardown() { }

  // The benchmark code.
  void run() {
    new Subclass.ConcreteCreator().productMaker();
  }
}

class FactoryMethodMapBenchmark extends BenchmarkBase {
  const FactoryMethodMapBenchmark() : super("Factory Method — Map of Factories");
  static void main() { new FactoryMethodMapBenchmark().report(); }
  void run() {
    new MapOfFactories.ConcreteCreator().productMaker();
  }
}

class FactoryMethodMirrorBenchmark extends BenchmarkBase {
  const FactoryMethodMirrorBenchmark() : super("Factory Method — Mirrors");
  static void main() { new FactoryMethodMirrorBenchmark().report(); }
  void run() {
    new Mirrors.ConcreteCreator().productMaker();
  }
}

main() {
  FactoryMethodSubclassBenchmark.main();
  FactoryMethodMapBenchmark.main();
  FactoryMethodMirrorBenchmark.main();
}
