#!/usr/bin/env dart

import 'dart:collection' show ListBase;
import 'dart:math' show Random;

// Creator
class GameFactory {
  String playerOne, playerTwo;
  GameFactory(this.playerOne, this.playerTwo);
  void start() { print(this); }
  String toString() => "*** $playerOne vs. $playerTwo ***";

  // The factory method
  BoardGame createBoardGame([String game]) {
    if (game == 'Checkers') return new CheckersGame();
    if (game == 'Thermo Nuclear War') return new ThermoNuclearWar();
    return new ChessGame();
  }
}

// Product *and* Creator
abstract class BoardGame {
  GamePieces playerOnePieces, playerTwoPieces;
  BoardGame() {
    playerOnePieces = _createPieces();
    playerTwoPieces = _createPieces();
  }
  GamePieces _createPieces();

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
  GamePieces _createPieces() => new ChessPieces();
}

class CheckersGame extends BoardGame {
  GamePieces _createPieces() => new CheckersPieces();
}

class ThermoNuclearWar extends BoardGame {
  GamePieces _createPieces() => new ThermoNuclearPieces();
  String get winner => "None";
}

class GamePieces extends ListBase {
  List<String> pieces = [];
  int get length => pieces.length;
  void set length(int i) { pieces.length = i; }
  operator [](int i)=> pieces[i];
  operator []=(int i, String other) { pieces[i] = other; }
  String toString() => pieces.join(', ');
}

class ThermoNuclearPieces extends GamePieces {
  List<String> pieces = [];
  ThermoNuclearPieces() : pieces = ['1,000 warheads'];
}

class CheckersPieces extends GamePieces {
  List<String> pieces = [];
  CheckersPieces() : pieces = ['12 pieces'];
}

class ChessPieces extends GamePieces {
  List<String> pieces = [];
  ChessPieces() : pieces = [
      '1 king', '1 queen', '2 rooks', '2 bishops', '2 knights', '8 pawns'
    ];
}

main() {
  var series = new GameFactory('Professor Falken', 'Joshua');

  series
    ..start()
    ..createBoardGame('Checkers').play()
    ..createBoardGame('Thermo Nuclear War').play()
    ..createBoardGame().play();
}
