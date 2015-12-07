#!/usr/bin/env dart

import 'package:command_code/light_machine.dart';

// Client
main(List<String> args) {
  var s = new Switch(),
    lamp = new Light();

  var switchUp = new OnCommand(lamp),
    switchDown = new OffCommand(lamp);

  args.forEach((command){
    switch (command) {
      case 'on':
        s.storeAndExecute(switchUp);
        break;
      case 'off':
        s.storeAndExecute(switchDown);
        break;
      default:
        print("Can only switch on or off");
    }
  });

  print('--');
  s.undo();
}
