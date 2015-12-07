library velvet_fog_machine;

import 'dart:convert';
import 'dart:math';

final rand = new Random(1);

String serializePlaylist(List<_Playing> list) => JSON.encode(list);
List<_Playing> deserializePlaylist(String json) {
  return JSON.decode(json).map((p) {
    var time = p['time'];
    var song = new Song(p['song']['title'], p['song']['album']);
    return new _Playing(song, time);
  });
}

// The "Originator"
class VelvetFogMachine {
  Song currentSong;
  double currentTime;

  static final VelvetFogMachine _vfm = new VelvetFogMachine._internal();
  factory VelvetFogMachine() => _vfm;
  VelvetFogMachine._internal();

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
  _Playing get nowPlaying {
    // Simulate playing at some time later:
    var time = (5*rand.nextDouble()*100).floor() / 100;

    return new _Playing(currentSong, time);
  }

  // Restore from memento
  void backTo(_Playing p) {
    print("  *** Whoa! This was a good one, let's hear it again :) ***");
    _play(p._song, p._time);
  }
}

class Song {
  String title, album;
  Song(this.title, this.album);
  String toString() => "$title // $album";
  Map toJson() =>  {'title': title, 'album': album};
}

// The Memento
class _Playing {
  Song _song;
  double _time;
  _Playing(this._song, this._time);
  Map toJson() => {'song': _song.toJson(), 'time': _time};
}
