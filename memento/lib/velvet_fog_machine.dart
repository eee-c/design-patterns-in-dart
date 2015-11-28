library velvet_fog_machine;

// The "Originator"
class VelvetFogMachine {
  List<String> _nowPlaying;

  // Set the state
  void play(String title, String album) {
    print("Playing $title // $album");
    _nowPlaying = [title, album];
  }

  // Return a memento for possible later restoration
  Memento get nowPlaying => new Memento(_nowPlaying.join(':::'));

  // Restore from memento
  void backTo(Memento memento) {
    print("  *** Whoa! This was a good one, let's hear it again :) ***");
    var previous = memento.state.split(':::');
    play(previous[0], previous[1]);
  }
}

class Memento {
  String state;
  Memento(this.state);
}
