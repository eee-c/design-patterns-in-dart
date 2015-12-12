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
  var menuPlay = new PlayCommand(machine),
    menuAddToPlaylist = new PlaylistAddCommand(playlist),
    menuRemoveFromPlaylist = new PlaylistRemoveCommand(playlist),
    menuClearPlaylist = new PlaylistClearCommand(playlist);

  menu.call(menuPlay, ['It Had to Be You']);

  print('--');
  menu.call(menuPlay, [playlist]);

  print('--');
  menu.call(menuAddToPlaylist, ['Blue Moon']);
  menu.call(menuPlay, [playlist]);

  print('--');
  menu.call(menuRemoveFromPlaylist, ['The Lady is a Tramp']);
  menu.call(menuPlay, [playlist]);

  print('--');
  menu.call(menuClearPlaylist);
  menu.call(menuPlay, [playlist]);
}
