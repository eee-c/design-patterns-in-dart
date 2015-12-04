#!/usr/bin/env dart

import 'package:memento_code/velvet_fog_machine.dart';

main() {
  List<Playing> replayer = [];

  var scatMan = new VelvetFogMachine();
  scatMan.play(
      'Blue Moon',
      'The Velvet Frog: The Very Best of Mel Tormé'
  );
  scatMan.play(
      '\'Round Midnight',
      'Tormé'
  );
  replayer.add(scatMan.nowPlaying);

  scatMan.play(
      'It Don\'t Mean A Thing (If It Ain\'t Got That Swing)',
      'Best Of/ 20th Century'
  );
  scatMan.play(
      'New York, New York Medley',
      'A Vintage Year'
  );
  replayer.add(scatMan.nowPlaying);
  replayer.add(scatMan.nowPlaying);
  replayer.add(scatMan.nowPlaying);
  replayer.add(scatMan.nowPlaying);

  scatMan.play(
      'The Lady is a Tramp',
      'The Velvet Frog: The Very Best of Mel Tormé'
  );

  // The New York, New York Medley with George Shearing really is wonderful
  scatMan.backTo(replayer.removeLast());
  scatMan.backTo(replayer.removeLast());
  scatMan.backTo(replayer.removeLast());
  scatMan.backTo(replayer.removeLast());
}

/* Test code for memento access */
  // // This should not work:
  // try {
  //   print("Caretaker says last remembered song is: ${replayer.last._song}");
  // }
  // on NoSuchMethodError {
  //   print("Yay! Caretaker was denied access to the memento song.");
  // }
