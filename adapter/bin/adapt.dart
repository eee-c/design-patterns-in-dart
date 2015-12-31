#!/usr/bin/env dart

import 'package:adapter_code/adaptee.dart';
import 'package:adapter_code/adapter.dart';

main() {
  var adaptee = new Adaptee();
  var adapter = new Adapter(adaptee);

  // Invoke a target method, not available on the adaptee:
  adapter.request();
}
