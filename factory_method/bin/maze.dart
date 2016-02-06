#!/usr/bin/env dart

import 'dart:math' show Random;

// Creator
abstract class MazeGame {
  List<Room> rooms = [];

  MazeGame() {
    Room room1 = _makeRoom();
    Room room2 = _makeRoom();
    room1.connect(room2);
    addRoom(room1);
    addRoom(room2);
  }

  Room _makeRoom();

  void addRoom(Room r) { rooms.add(r); }

  String toString() =>
    "${this.runtimeType} has ${rooms.length} rooms: "
    "${rooms.join(', ')}";
}

// Concrete Creator #1
class MagicMazeGame extends MazeGame {
  @override
  Room _makeRoom() => new MagicRoom();
}

// Concrete Creator #2
class OrdinaryMazeGame extends MazeGame {
  @override
  Room _makeRoom() => new OrdinaryRoom();
}

// Concrete Creator #3
class CrazyMazeGame extends MazeGame {
  @override
  Room _makeRoom() =>
    new Random().nextBool() ? new OrdinaryRoom() : new MagicRoom();
}

// Product
class Room {
  List<Room> connectedRooms = [];

  void connect(Room other) {
    connectedRooms.add(other);
  }
}

// Concrete Product #1
class MagicRoom extends Room {}

// Concrete Product #1
class OrdinaryRoom extends Room {}

main() {
  MazeGame ordinaryGame = new OrdinaryMazeGame();
  MazeGame magicGame = new MagicMazeGame();
  MazeGame crazyGame = new CrazyMazeGame();

  print(ordinaryGame);
  print(magicGame);
  print(crazyGame);
}
