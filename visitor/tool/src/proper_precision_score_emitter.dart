library score_emitter;

import 'package:benchmark_harness/benchmark_harness.dart';

class ProperPrecisionScoreEmitter implements ScoreEmitter {
  const ProperPrecisionScoreEmitter();

  void emit(String testName, double value) {
    print('$testName (RunTime), ${value.toStringAsPrecision(4)}, µs');
  }
}
