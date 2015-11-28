#!/usr/bin/env dart

import 'package:memento_code/velvet_fog_machine.dart';

main() {
  List<Memento> replayer = [];

  var scatter = new VelvetFogMachine();
  scatter.play(
      'Blue Moon',
      'The Velvet Frog: The Very Best of Mel Tormé'
  );
  scatter.play(
      '\'Round Midnight',
      'Tormé'
  );
  replayer.add(scatter.nowPlaying);

  scatter.play(
      'It Don\'t Mean A Thing (If It Ain\'t Got That Swing)',
      'Best Of/ 20th Century'
  );
  scatter.play(
      'New York, New York Medley',
      'A Vintage Year'
  );
  replayer.add(scatter.nowPlaying);

  scatter.play(
      'The Lady is a Tramp',
      'The Velvet Frog: The Very Best of Mel Tormé'
  );

  // The New York, New York Medley with George Shearing really is wonderful
  scatter.backTo(replayer[1]);
}
