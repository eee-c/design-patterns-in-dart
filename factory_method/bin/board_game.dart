#!/usr/bin/env dart

import 'dart:math' show Random;

// Creator
@proxy
class GameFactory {
  String playerOne, playerTwo;
  GameFactory(this.playerOne, this.playerTwo);
  void start() { print(this); }
  String toString() => "*** $playerOne vs. $playerTwo ***";

  // The factory method
  factory GameFactory.createBoardGame([String game]) {
    if (game == 'Checkers') return new CheckersGame();
    if (game == 'Thermo Nuclear War') return new ThermoNuclearWar();
    return new ChessGame();
  }
}

// Product
class BoardGame {
  List playerOnePieces = [];
  List playerTwoPieces = [];
  void play() { print(this); }
  String get winner => new Random().nextBool() ? "Player One" : "Player Two";
  String toString() =>
    "  ${this.runtimeType}\n"
    "    Player One starts with: ${playerOnePieces.join(', ')}\n"
    "    Player Two starts with: ${playerTwoPieces.join(', ')}\n"
    "    --\n"
    "    Winner: $winner\n";
}

class ChessGame extends BoardGame {
  List playerOnePieces = [
    '1 king', '1 queen', '2 rooks', '2 bishops', '2 knights', '8 pawns'
  ];
  List playerTwoPieces = [
    '1 king', '1 queen', '2 rooks', '2 bishops', '2 knights', '8 pawns'
  ];
}

class CheckersGame extends BoardGame {
  List playerOnePieces = [ '12 pieces' ];
  List playerTwoPieces = [ '12 pieces' ];
}

class ThermoNuclearWar extends BoardGame {
  List playerOnePieces = [ '1,000 warheads' ];
  List playerTwoPieces = [ '1,000 warheads' ];
  String get winner => "None";
}

main() {
  var series = new GameFactory('Professor Falken', 'Joshua');
  series.start();

  new GameFactory.createBoardGame('Checkers').play();
  new GameFactory.createBoardGame('Thermo Nuclear War').play();
  new GameFactory.createBoardGame().play();
}
