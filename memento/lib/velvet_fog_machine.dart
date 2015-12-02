library velvet_fog_machine;

import 'dart:math';
final rand = new Random(1);

// The "Originator"
class VelvetFogMachine {
  Song currentSong;
  double currentTime;
  final double _secret = rand.nextDouble();

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

    return new Playing.forTheVelvetFogMachine(currentSong, time, _secret);
  }

  // Restore from memento
  void backTo(Playing p) {
    print("  *** Whoa! This was a good one, let's hear it again :) ***");
    _play(p.secretSong(_secret), p.secretTime(_secret));
  }
}

class Song {
  String title, album;
  Song(this.title, this.album);
  String toString() => "$title // $album";
}

// The Memento
class Playing {
  Song _song;
  double _time;
  double _secret;

  // Narrow interface for the world
  Playing();

  // Wide interface for the VelvetFogMachine
  Playing.forTheVelvetFogMachine(this._song, this._time, this._secret);

  Song secretSong(double secret) {
    // Runtime check for access
    _checkAccess(secret, #secretSong);
    return _song;
  }

  double secretTime(double secret) {
    // Runtime check for access
    _checkAccess(secret, #secretTime);
    return _time;
  }

  _checkAccess(secret, memberName) {
    if (secret == _secret) return;

    throw new NoSuchMethodError(this, memberName, [secret], {});
  }
}
