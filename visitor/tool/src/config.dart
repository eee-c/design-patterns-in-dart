library benchmark_config;

import 'package:args/args.dart';

class Config {
  int loopSize, numberOfRuns;

  Config(List<String> args) {
    var conf = _parser.parse(args);
    loopSize = int.parse(conf['loop-size']);
    numberOfRuns = int.parse(conf['number-of-runs']);
  }

  ArgParser get _parser => new ArgParser()
    ..addOption('loop-size', abbr: 's', defaultsTo: '10')
    ..addOption('number-of-runs', abbr: 'n', defaultsTo: '3');
}
