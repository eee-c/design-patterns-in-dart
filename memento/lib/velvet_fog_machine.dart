library velvet_fog_machine;

import 'dart:math';
final rand = new Random(1);

// The "Originator"
class VelvetFogMachine {
  Song currentSong;
  double currentTime;

  // Set the state
  void play(String title, String album, [double time = 0.0]) {
    _play(new Song(title, album), time);
  }

  void _play(Song s, double t) {
    currentSong = s;
    currentTime = t;
    print("Playing $currentSong @ ${currentTime.toStringAsFixed(2)}");
  }

  // Create a memento of the current state
  Playing get nowPlaying {
    // Simulate playing at some time later:
    var time = 5*rand.nextDouble();

    return new Playing(currentSong, time);
  }

  // Restore from memento
  void backTo(Playing p) {
    print("  *** Whoa! This was a good one, let's hear it again :) ***");
    _play(p.song, p.time);
  }
}

class Song {
  String title, album;
  Song(this.title, this.album);
  String toString() => "$title // $album";
}

// The Memento
class Playing {
  Song song;
  double time;
  Playing(this.song, this.time);
}
