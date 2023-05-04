import 'package:equatable/equatable.dart';

enum Player {
  playerX,
  playerO,
}

class CellCordinate extends Equatable {
  final int x;
  final int y;
  Player? currentPlayer;

  CellCordinate(
    this.x,
    this.y,
  );

  set setCurrentPlayer(Player currentPlayer) => currentPlayer = currentPlayer;

  String get getTextPlayer => currentPlayer == null
      ? ""
      : currentPlayer! == Player.playerX
          ? "X"
          : "O";
  String get coordinateString => "($x,$y)";

  bool isValid({
    required int maxX,
    required int maxY,
  }) {
    if (x < 0) return false;
    if (y < 0) return false;
    if (x >= maxX) return false;
    if (y >= maxY) return false;
    return true;
  }

  @override
  List<Object> get props => [x, y];

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "current_player": getTextPlayer,
      };

  @override
  String toString() {
    return "CellCoordinate($x,$y*$getTextPlayer*)";
  }
}
