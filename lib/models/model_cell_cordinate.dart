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
  String get coordinateString => "($col,$row)";

  bool isValid({
    required int maxCol,
    required int maxRow,
  }) {
    if (col < 0) return false;
    if (row < 0) return false;
    if (col >= maxCol) return false;
    if (row >= maxRow) return false;
    return true;
  }

  @override
  List<Object> get props => [col, row];

  Map<String, dynamic> toJson() => {
        "col": col,
        "row": row,
        "current_player": getTextPlayer,
      };
}
