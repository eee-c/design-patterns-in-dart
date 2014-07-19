library score_emitter;

import 'dart:io';

import 'package:benchmark_harness/benchmark_harness.dart';

const LOOP_RESULTS_FILE = 'tmp/benchmark_loop_runs.tsv';
const SUMMARY_FILE = 'tmp/benchmark_summary.tsv';

class ProperPrecisionScoreEmitter implements ScoreEmitter {
  const ProperPrecisionScoreEmitter();

  void emit(String testName, double value) {
    print('$testName (RunTime), ${value.toStringAsPrecision(4)}, µs');
  }
}

void recordTsvRecord(name, score, loopSize) {
  print(tsvLoop(name, score, loopSize));
}

String tsvLoop(name, score, loopSize) =>
  '${name} (RunTime in µs)\t'
  '${score.toStringAsPrecision(4)}\t'
  '${loopSize}\t'
  '${(score/loopSize).toStringAsPrecision(4)}';

recordTsvTotal(name, results, loopSize, numberOfRuns) {
  var averageScore = results.fold(0, (prev, element) => prev + element) /
    numberOfRuns;

  var tsv =
    '${name}\t'
    '${averageScore.toStringAsPrecision(4)}\t'
    '${loopSize}\t'
    '${(averageScore/loopSize).toStringAsPrecision(4)}';

  print(tsv);
  var file = new File(LOOP_RESULTS_FILE);
  file.openSync(mode: FileMode.APPEND)
    ..writeStringSync('$tsv\n')
    ..closeSync();
}
