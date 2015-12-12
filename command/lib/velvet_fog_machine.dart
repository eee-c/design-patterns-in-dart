library velvet_fog_machine;

// Invoker
class Menu {
  List _history = [];

  void call(Command c, [List args]) {
    if (args != null)
      c.call(args);
    else
      c.call();

    _history.add([c, args]);
  }
}

// Receiver
class VelvetFogMachine {
  void play(song) {
    print("Play $song");
  }
}

// Receiver
class Playlist {
  List<String> songs = [];
  Playlist(this.songs);
  void add(List<String> s) => songs.addAll(s);
  bool remove(String s) => songs.remove(s);
  void clear() { songs.clear(); }
  String toString() => songs.join("\n     ");
}

abstract class Command {
  void call([List args]);
}

class PlayCommand implements Command {
  VelvetFogMachine machine;
  PlayCommand(this.machine);
  void call([List args]) {
    machine.play(args.first);
  }
}

class PlaylistAddCommand implements Command {
  Playlist playlist;
  PlaylistAddCommand(this.playlist);
  void call([List args]) {
    print('==> [add] ${args.first}');
    playlist.add(args);
  }
}

class PlaylistRemoveCommand implements Command {
  Playlist playlist;
  PlaylistRemoveCommand(this.playlist);
  void call([List args]) {
    print('==> [remove] ${args.first}');
    playlist.remove(args.first);
  }
}

class PlaylistClearCommand implements Command {
  Playlist playlist;
  PlaylistClearCommand(this.playlist);
  void call([_]) {
    print('==> [clear]');
    playlist.clear();
  }
}
