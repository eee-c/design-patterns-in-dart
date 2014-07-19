#!/usr/bin/env dart

import 'dart:io';

import 'src/score_emitters.dart';

main() {
  List<Map> totals = _readTotals();
  var loopSizes = totals.map((r)=> r['loopSize']).toSet();
  var implementations = totals.map((r)=> r['name']).toSet();

  // gnuplot likes header w/o spaces...
  var header = ['Loop_Size']..addAll(
      implementations.map((i)=> i.replaceAll(' ', '_'))
    );
  _saveRow(header);

  loopSizes.forEach((loopSize) {
    var records = totals.where((r)=> r['loopSize'] == loopSize);

    var row = [loopSize];
    implementations.forEach((implementation){
      var rec = records.firstWhere((r)=> r['name'] == implementation);
      row.add(rec["averageScore"]);
    });
    _saveRow(row);
  });
}

_saveRow(row) {
  var file = new File(SUMMARY_FILE);
  file.openSync(mode: FileMode.APPEND)
    ..writeStringSync('${row.join("\t")}\n')
    ..closeSync();
}

_readTotals() {
  var file = new File(LOOP_RESULTS_FILE);
  var lines = file.readAsLinesSync();

  return lines.map((line){
    var fields = line.split('\t');
    return {
      'name': fields[0],
      'score': fields[1],
      'loopSize': fields[2],
      'averageScore': fields[3]
    };
  }).toList();
}
