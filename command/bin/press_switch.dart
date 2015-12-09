#!/usr/bin/env dart

import 'dart:async';

import 'package:command_code/light_machine.dart';

// Client
main(List<String> commands) {
  // Invoker
  var s = new Switch();

  // Receiver
  var lamp = new Light();

  // Concrete command instances
  var switchUp = new OnCommand(lamp),
    switchDown = new OffCommand(lamp);

  // // Concrete command instances (callback version)
  // var switchUp = (){ lamp.turn('ON'); },
  //   switchDown = (){ lamp.turn('OFF'); };

  // Command queue
  var queue = commands.map((command){
    if (command == 'on') return switchUp;
    if (command == 'off') return switchDown;
    print("Can only switch on or off");
  }).toList();

  var index = 0;
  new Timer.periodic(new Duration(seconds: 1), (timer){
    s.storeAndExecute(queue[index++]);

    if (index >= queue.length) {
      timer.cancel();
      s.undo();
    }
  });
}
