#!/usr/bin/env dart

import 'dart:io';

const CSV_FILE = 'totals.csv';

main() {
  List<Map> totals = _readTotals();
  var loopSizes = totals.map((r)=> r['loopSize']).toSet();

  loopSizes.forEach((loopSize) {
    var records = totals.where((r)=> r['loopSize'] == loopSize);

    var classic = records.firstWhere((r)=> r['name'].contains('Classic'));
    var single = records.firstWhere((r)=> r['name'].contains('single'));
    var vTraverses = records.firstWhere((r)=> r['name'].contains('Traverses'));

    print(
      '${loopSize}, '
      '${classic["averageScore"]}, '
      '${single["averageScore"]}, '
      '${vTraverses["averageScore"]}'
    );
  });
}

_readTotals() {
  var file = new File('totals.csv');
  var lines = file.readAsLinesSync();

  return lines.map((line){
    var fields = line.split(', ');
    return {
      'name': fields[0],
      'score': fields[1],
      'loopSize': fields[2],
      'averageScore': fields[3]
    };
  }).toList();
}
