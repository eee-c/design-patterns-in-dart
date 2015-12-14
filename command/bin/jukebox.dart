#!/usr/bin/env dart

import 'package:command_code/velvet_fog_machine.dart';

// Client
main() {
  // Receivers
  var machine = new VelvetFogMachine();
  var playlist = new Playlist([
    '\'Round Midnight',
    'It Don\'t Mean A Thing (If It Ain\'t Got That Swing)',
    'New York, New York',
    'The Lady is a Tramp'
  ]);

  // Concrete command instances
  var play = new PlayCommand(machine),
    playlistAdd = new PlaylistAddCommand(playlist),
    playlistRemove = new PlaylistRemoveCommand(playlist),
    playlistClear = new PlaylistClearCommand(playlist);

  // Invokers
  var menuPlay =
    new MenuItem("Play", play);

  var menuPlaylistAdd =
    new MenuItem("Add to Playlist", playlistAdd);

  var menuPlaylistRemove =
    new MenuItem("Remove From Playlist", playlistRemove);

  var menuPlaylistClear =
    new MenuItem("Clear From Playlist", playlistClear);


  menuPlay.call(['It Had to Be You']);
  menuPlay.call(['Cheek to Cheek']);
  menuPlay.call(['At Last']);
  MenuItem.undo();
  // // TODO: Bug in multiple undos
  // MenuItem.undo();

  print('--');
  menuPlay.call( [playlist]);

  print('--');
  menuPlaylistRemove.call(['New York, New York']);
  MenuItem.undo();
  menuPlay.call([playlist]);

  print('--');
  menuPlaylistAdd.call(['Blue Moon']);
  menuPlay.call([playlist]);

  print('--');
  menuPlaylistClear.call();
  MenuItem.undo();
  menuPlay.call([playlist]);

  print('--');
  MenuItem.undoAll();
}
