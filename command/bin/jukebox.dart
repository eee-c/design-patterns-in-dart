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
  var btnPlay =
    new Button("Play", play);

  var btnPlaylistAdd =
    new Button("Add to Playlist", playlistAdd);

  var btnPlaylistRemove =
    new Button("Remove From Playlist", playlistRemove);

  var btnPlaylistClear =
    new Button("Clear From Playlist", playlistClear);


  btnPlay.call(['It Had to Be You']);
  btnPlay.call(['Cheek to Cheek']);
  btnPlay.call(['At Last']);
  Button.undo();
  Button.undo();

  print('--');
  btnPlay.call( [playlist]);

  print('--');
  btnPlaylistRemove.call(['New York, New York']);
  Button.undo();
  btnPlay.call([playlist]);

  print('--');
  btnPlaylistAdd.call(['Blue Moon']);
  btnPlay.call([playlist]);

  print('--');
  btnPlaylistClear.call();
  Button.undo();
  btnPlay.call([playlist]);

  print('--');
  Button.undoAll();
}
