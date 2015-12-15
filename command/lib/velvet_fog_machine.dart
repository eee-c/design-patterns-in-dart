library velvet_fog_machine;

// Invoker
class Button {
  static List _history = [];

  String name;
  Command command;
  Button(this.name, this.command);

  void call([List args]) {
    if (args != null)
      command.call(args);
    else
      command.call();

    _history.add(command._clone());
  }

  static void undo() {
    var h = _history.removeLast();
    print("Undoing $h");
    h.undo();
  }

  static void undoAll() {
    _history.forEach((h) { print(h); });
  }
}

// Receiver
class VelvetFogMachine {
  String currentSong = 'OFF';
  void play(song) {
    print("Play $song");
    currentSong = song;
  }
}

// Receiver
class Playlist {
  List<String> songs = [];
  Playlist(this.songs);
  void add(List<String> s) => songs.addAll(s);
  bool remove(String s) => songs.remove(s);
  void clear() { songs.clear(); }
  Playlist clone() => new Playlist(songs.map((s)=> s).toList());
  String toString() => songs.join("\n     ");
}

abstract class Command {
  void call([List args]);
  void undo();
  Command _clone();
}

class PlayCommand implements Command {
  VelvetFogMachine machine;
  String _prevSong;

  PlayCommand(this.machine);

  void call([List args]) {
    _prevSong = machine.currentSong;
    machine.play(args.first);
  }

  void undo() {
    machine.play(_prevSong);
  }

  PlayCommand _clone() =>
    new PlayCommand(machine)
        .._prevSong = _prevSong;
}

class PlaylistAddCommand implements Command {
  Playlist playlist, _prev;

  PlaylistAddCommand(this.playlist);
  void call([List args]) {
    _prev = playlist.clone();
    print('==> [add] ${args.first}');
    playlist.add(args);
  }

  void undo() {
    playlist.songs = _prev.songs;
  }

  Command _clone() => this;
}

class PlaylistRemoveCommand implements Command {
  Playlist playlist, _prev;

  PlaylistRemoveCommand(this.playlist);

  void call([List args]) {
    _prev = playlist.clone();
    print('==> [remove] $args');
    playlist.remove(args.first);
  }

  void undo() {
    playlist.songs = _prev.songs;
  }

  Command _clone() => this;
}

class PlaylistClearCommand implements Command {
  Playlist playlist, _prev;

  PlaylistClearCommand(this.playlist);

  void call([_]) {
    _prev = playlist.clone();
    print('==> [clear]');
    playlist.clear();
  }

  void undo() {
    playlist.songs = _prev.songs;
  }

  Command _clone() => this;
}
