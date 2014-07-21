#!/usr/bin/env dart

import 'dart:io';

main() {
  List<Map> totals = _readTotals();
  var loopSizes = totals.map((r)=> r['loopSize']).toSet();
  var implementations = totals.map((r)=> r['name']).toSet();

  // gnuplot likes header w/o spaces...
  var header = ['Loop_Size']..addAll(
      implementations.map((i)=> i.replaceAll(' ', '_'))
    );
  _recordTsvRecord(header);

  loopSizes.forEach((loopSize) {
    var records = totals.where((r)=> r['loopSize'] == loopSize);

    var row = [loopSize];
    implementations.forEach((implementation){
      var rec = records.firstWhere((r)=> r['name'] == implementation);
      row.add(rec["averageScore"]);
    });
    _recordTsvRecord(row);
  });
}

void _recordTsvRecord(row) {
  print(row.join("\t"));
}

_readTotals() {
  var lines = [];

  var line;
  while ((line = stdin.readLineSync()) != null) {
    var fields = line.split('\t');
    lines.add({
      'name': fields[0],
      'score': fields[1],
      'loopSize': fields[2],
      'averageScore': fields[3]
    });
  }

  return lines;
}
