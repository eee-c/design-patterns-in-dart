#!/usr/bin/env dart

import 'dart:math' show Random;

// Creator
class GameFactory {
  String playerOne, playerTwo;
  GameFactory(this.playerOne, this.playerTwo);
  String toString() => "*** $playerOne vs. $playerTwo ***";

  // The factory method
  BoardGame createBoardGame([String game]) {
    if (game == 'Checkers') return new CheckersGame();
    if (game == 'Thermo Nuclear War') return new ThermoNuclearWar();
    return new ChessGame();
  }
}

// Product
class BoardGame {
  List playerOnePieces = [];
  List playerTwoPieces = [];
  String get winner => new Random().nextBool() ? "Player One" : "Player Two";
  String toString() =>
    "  ${this.runtimeType}\n"
    "    Player One has: ${playerOnePieces.join(', ')}\n"
    "    Player Two has: ${playerTwoPieces.join(', ')}\n"
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
  print(series);

  var game;
  game = series.createBoardGame('Checkers');
  print(game);

  game = series.createBoardGame('Thermo Nuclear War');
  print(game);

  game = series.createBoardGame();
  print(game);
}
