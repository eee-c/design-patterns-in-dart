#!/usr/bin/env dart

import 'package:command_code/velvet_fog_machine.dart';

// Client
main() {
  // Invoker
  var menu = new Menu();

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
    addToPlaylist = new PlaylistAddCommand(playlist),
    removeFromPlaylist = new PlaylistRemoveCommand(playlist),
    clearPlaylist = new PlaylistClearCommand(playlist);

  menu.call(play, ['It Had to Be You']);
  menu.call(play, ['Cheek to Cheek']);
  menu.undo();

  print('--');
  menu.call(play, [playlist]);

  print('--');
  menu.call(removeFromPlaylist, ['New York, New York']);
  menu.undo();
  menu.call(play, [playlist]);

  print('--');
  menu.call(addToPlaylist, ['Blue Moon']);
  menu.call(play, [playlist]);

  print('--');
  menu.call(clearPlaylist);
  menu.undo();
  menu.call(play, [playlist]);

  print('--');
  menu.undoAll();
}
