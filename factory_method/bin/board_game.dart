#!/usr/bin/env dart

import 'dart:math' show Random;
import 'dart:mirrors' show reflectClass, ClassMirror;

// Creator
class GameFactory {
  String playerOne, playerTwo;
  GameFactory(this.playerOne, this.playerTwo);
  void start() { print(this); }
  String toString() => "*** $playerOne vs. $playerTwo ***";

  // The factory method
  ClassMirror boardGameClass([String game]) {
    if (game == 'Checkers') return reflectClass(CheckersGame);
    if (game == 'Thermo Nuclear War') return reflectClass(ThermoNuclearWar);
    return reflectClass(ChessGame);
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
  ThermoNuclearWar(): super();
  ThermoNuclearWar.withWarheads(this.playerOnePieces, this.playerTwoPieces);
  String get winner => "None";
}

main() {
  var series = new GameFactory('Professor Falken', 'Joshua');
  series.start();

  var game;
  game = series.
    boardGameClass('Checkers').
    newInstance(new Symbol(''), []).
    reflectee;
  game.play();

  game = series.
    boardGameClass('Thermo Nuclear War').
    newInstance(new Symbol(''), []).
    reflectee;
  game.play();

  game = series.
    boardGameClass('Thermo Nuclear War').
    newInstance(
      new Symbol('withWarheads'),
      [['1 warhead'], ['1 warhead']]
    ).
    reflectee;
  game.play();

  game = series.
    boardGameClass('Thermo Nuclear War').
    newInstance(
      new Symbol('withWarheads'),
      [['1 warhead'], ['1,000 warheads']]
    ).
    reflectee;
  game.play();

  // Defaults to a nice game of chess
  game = series.
    boardGameClass().
    newInstance(new Symbol(''), []).
    reflectee;
  game.play();
}
