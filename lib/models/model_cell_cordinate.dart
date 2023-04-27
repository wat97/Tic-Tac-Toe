import 'package:equatable/equatable.dart';

enum Player {
  playerX,
  playerO,
}

class CellCordinate extends Equatable {
  final int col;
  final int row;
  Player? currentPlayer;

  CellCordinate(
    this.col,
    this.row,
  );

  set setCurrentPlayer(Player currentPlayer) => currentPlayer = currentPlayer;

  String get getTextPlayer => currentPlayer == null
      ? ""
      : currentPlayer! == Player.playerX
          ? "X"
          : "O";

  @override
  List<Object> get props => [col, row];
}
