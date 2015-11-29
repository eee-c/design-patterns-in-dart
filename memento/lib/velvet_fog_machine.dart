library velvet_fog_machine;

import 'dart:math';

// The "Originator"
class VelvetFogMachine {
  // The Memento
  Playing _nowPlaying;

  // Set the state
  void play(String title, String album, [double time = 0.0]) {
    print("Playing $title // $album @ ${time.toStringAsFixed(2)}");
    _nowPlaying = new Playing(title, album, time);
  }

  Playing get nowPlaying {
    _nowPlaying.time = 5*rand.nextDouble();
    return _nowPlaying;
  }

  // Restore from memento
  void backTo(Playing memento) {
    print("  *** Whoa! This was a good one, let's hear it again :) ***");
    play(memento.title, memento.album, memento.time);
  }
}

final rand = new Random(1);

// The Memento
class Playing {
  String title, album;
  double time;
  Playing(this.title, this.album, this.time);
}
