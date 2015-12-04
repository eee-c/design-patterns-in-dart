library velvet_fog_machine;

import 'dart:math';
final rand = new Random(1);

// The "Originator"
class VelvetFogMachine {
  Song currentSong, _lastSong;
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
    currentTime += 2*rand.nextDouble();

    var song  = (_lastSong == currentSong) ? null : currentSong;
    _lastSong = currentSong;

    return new Playing(song, currentTime);
  }

  // Restore from memento
  void backTo(Playing p) {
    print("\n===> (backTo)");
    print(p._song);
    var song = (p._song == null) ? _lastSong : p._song;
    _play(song, p._time);
  }
}

class Song {
  String title, album;
  Song(this.title, this.album);
  String toString() => "$title // $album";
  bool operator ==(other) {
    print('====');
    return this.title == other.title &&
      this.album == other.album;
  }
}

// The Memento
class Playing {
  Song _song;
  double _time;
  Playing(this._song, this._time);
}
