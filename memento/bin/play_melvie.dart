#!/usr/bin/env dart

import 'package:memento_code/velvet_fog_machine.dart';

main() {
  List replayer = [];

  var scatMan = new VelvetFogMachine();
  scatMan.play(
      'Blue Moon',
      'The Velvet Frog: The Very Best of Mel Tormé'
  );
  scatMan = new VelvetFogMachine();
  print("New instance is playing: ${scatMan.currentSong}");
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

  scatMan.play(
      'The Lady is a Tramp',
      'The Velvet Frog: The Very Best of Mel Tormé'
  );

  // The New York, New York Medley with George Shearing really is wonderful
  scatMan.backTo(replayer.last);

  print('--');
  var saved = serializePlaylist(replayer);
  var restored = deserializePlaylist(saved);
  scatMan.backTo(restored.first);
}

  // // This should not work:
  // try {
  //   print(replayer.last);
  //   print("Caretaker says last remembered song is: ${replayer.last._song}");
  // }
  // on NoSuchMethodError {
  //   print("Yay! Caretaker was denied access to the memento song.");
  // }
