library score_emitter;

import 'dart:io';

import 'package:benchmark_harness/benchmark_harness.dart';

class ProperPrecisionScoreEmitter implements ScoreEmitter {
  const ProperPrecisionScoreEmitter();

  void emit(String testName, double value) {
    print('$testName (RunTime), ${value.toStringAsPrecision(4)}, µs');
  }
}

void recordCsvRecord(name, score, loopSize) {
  print(csvLoop(name, score, loopSize));
}

String csvLoop(name, score, loopSize) =>
  '${name} (RunTime in µs), '
  '${score.toStringAsPrecision(4)}, '
  '${loopSize}, '
  '${(score/loopSize).toStringAsPrecision(4)}';

recordCsvTotal(name, results, loopSize, numberOfRuns) {
  var averageScore = results.fold(0, (prev, element) => prev + element) /
    numberOfRuns;

  var csv =
    '${name}, '
    '${averageScore.toStringAsPrecision(4)}, '
    '${loopSize}, '
    '${(averageScore/loopSize).toStringAsPrecision(4)}';

  print(csv);
  var file = new File('totals.csv');
  file.openSync(mode: FileMode.APPEND)
    ..writeStringSync('$csv\n')
    ..closeSync();
}
