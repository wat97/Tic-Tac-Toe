import '../../models/models.dart';

/// Game Service for Tic Tac Toe
class GameService {
  /// To Create how big the tic tac toe board
  final int maxWidth;

  /// To Create condition win
  final int conditionWinner;

  /// Contains Every cell in board
  List<Cell> boardTicTacToe = [];

  /// Who running game
  Player currentPlayer;

  Function? _functionRefresh;

  Cell? clickedCell;
  GameService({
    required this.maxWidth,
    required this.conditionWinner,
    required this.currentPlayer,
  })
  // : assert(maxWidth >= 3),
  //       assert(conditionWinner >= maxWidth)
  ;

  /// To get the index to how many cells are selected
  int get getIndexClickedCell => boardTicTacToe.indexWhere(
      (element) => element == clickedCell && element.currentPlayer == null);

  int get width => maxWidth;

  set setRefresh(Function? functionRefresh) =>
      _functionRefresh = functionRefresh;

  /// To generate board Tic Tac Toe
  createBoard() {
    for (var i = 0; i < maxWidth; i++) {
      for (var j = 0; j < maxWidth; j++) {
        Cell cell = Cell(i, j);
        boardTicTacToe.add(cell);
      }
    }
    _functionRefresh!();
  }

  logicClick({
    required Player currentPlayer,
    required Cell clickedCell,
  }) {
    this.currentPlayer = currentPlayer;
    this.clickedCell = clickedCell;
    int indexCell = getIndexClickedCell;
    if (indexCell >= 0) {
      boardTicTacToe.elementAt(indexCell).currentPlayer = this.currentPlayer;

      /// update player after play
      // print("Logic Click ${this.currentPlayer} === ${currentPlayer}");
      this.currentPlayer =
          currentPlayer == Player.playerX ? Player.playerO : Player.playerX;
      // print("Logic after Click ${this.currentPlayer} === ${currentPlayer}");

      _functionRefresh!();
    }
  }

  /// To get winner player
  Player? get winnerPlayer {
    int countingWin = 1;
    Player? player;

    for (var elementCell in boardTicTacToe) {
      countingWin = 1;
      player = null;
      for (var lineCell in getValidLines(elementCell)) {
        player = null;
        for (var cellAlone in lineCell) {
          if (player == cellAlone.currentPlayer &&
              cellAlone.currentPlayer != null) {
            print(
                "Before winner $player | ${cellAlone} | $countingWin | $conditionWinner");
            countingWin++;
            if (countingWin == conditionWinner) {
              print("lineCell $lineCell ($countingWin) ($conditionWinner)");
              return player;
            }
            print(
                "winner $player | ${cellAlone} | $countingWin | $conditionWinner");
          } else {
            countingWin = 1;
            player = cellAlone.currentPlayer;
            print(
                "winner $player | ${cellAlone} | $countingWin | $conditionWinner");
          }
        }
        print("======|$player|$countingWin|=========");
      }
    }
    return null;
  }

  Iterable<List<Cell>> getValidLines(Cell cell) sync* {
    /// get horizontal line
    yield horizontalLines(cell);

    /// get vertical line
    yield verticalLines(cell);

    /// get down wart diagonal line
    yield downWardLines(cell);

    /// get up wart diagonal line
    yield upWardLines(cell);
  }

  /// to generate cell horizontal lines
  List<Cell> horizontalLines(Cell cell) {
    firstLoop:
    for (var startX = cell.x - maxWidth + 1; startX <= cell.x; startX++) {
      final startCell = Cell(startX, cell.y);
      if (!startCell.isValid(
        maxX: maxWidth,
        maxY: maxWidth,
      )) continue;
      final endCell = Cell(startCell.x + maxWidth - 1, cell.y);
      if (!endCell.isValid(
        maxX: maxWidth,
        maxY: maxWidth,
      )) continue;
      List<Cell> iterateCell = [];
      int filled = 0;
      for (var i = startCell.x; i <= endCell.x; i++) {
        Cell cellTemp =
            boardTicTacToe.firstWhere((element) => element == Cell(i, cell.y));
        iterateCell.add(cellTemp);
        if (cellTemp.currentPlayer == null) {
          filled++;
        }
      }
      if (filled < conditionWinner) {
        return [];
      }
      return iterateCell;
    }
    return [];
  }

  /// to generate cell Vertikal lines
  List<Cell> verticalLines(Cell cell) {
    outerloop:
    for (var startY = cell.y - maxWidth + 1; startY <= cell.y; startY++) {
      final startCell = Cell(cell.x, startY);
      if (!startCell.isValid(
        maxX: maxWidth,
        maxY: maxWidth,
      )) continue;
      final endCell = Cell(cell.x, startCell.y + maxWidth - 1);
      if (!endCell.isValid(
        maxX: maxWidth,
        maxY: maxWidth,
      )) continue;
      List<Cell> iterateCell = [];
      int filled = 0;
      for (var i = startCell.y; i <= endCell.y; i++) {
        Cell cellTemp =
            boardTicTacToe.firstWhere((element) => element == Cell(cell.x, i));
        iterateCell.add(cellTemp);
        if (cellTemp.currentPlayer == null) {
          filled++;
        }
      }
      if (filled < conditionWinner) {
        return [];
      }
      return iterateCell;
    }
    return [];
  }

  /// to generate cell down ward diagonal lines
  List<Cell> downWardLines(Cell cell) {
    outerloop:
    for (var xOffset = -maxWidth + 1; xOffset <= 0; xOffset++) {
      var yOffset = xOffset;
      final startCell = Cell(cell.x + xOffset, cell.y + yOffset);
      if (!startCell.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
      final endCell =
          Cell(startCell.x + maxWidth - 1, startCell.y + maxWidth - 1);
      if (!endCell.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
      List<Cell> iterateCell = [];
      int filled = 0;
      for (var i = 0; i < maxWidth; i++) {
        Cell cellTemp = boardTicTacToe.firstWhere(
            (element) => element == Cell(startCell.x + i, startCell.y + i));
        iterateCell.add(cellTemp);
        if (cellTemp.currentPlayer == null) filled++;
      }
      if (filled < conditionWinner) {
        return [];
      }
      return iterateCell;
    }
    return [];
  }

  /// to generate cell up ward diagonal lines
  List<Cell> upWardLines(Cell cell) {
    outerloop:
    for (var xOffset = -maxWidth + 1; xOffset <= 0; xOffset++) {
      var yOffset = -xOffset;
      final startCell = Cell(cell.x + xOffset, cell.y + yOffset);
      if (!startCell.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
      final endCell =
          Cell(startCell.x + maxWidth - 1, startCell.y - maxWidth + 1);
      if (!endCell.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
      List<Cell> iterateCell = [];
      int filled = 0;
      for (var i = 0; i < maxWidth; i++) {
        Cell cellTemp = boardTicTacToe.firstWhere(
            (element) => element == Cell(startCell.x + i, startCell.y - i));
        iterateCell.add(cellTemp);
        if (cellTemp.currentPlayer == null) filled++;
      }
      if (filled < conditionWinner) {
        return [];
      }
      return iterateCell;
    }
    return [];
  }

  Cell processCellBoard(Cell cell) {
    var cellBoard = boardTicTacToe.where((element) => element == cell).toList();
    if (cellBoard.isNotEmpty) {
      return cellBoard.first;
    }
    return cell;
  }
}
