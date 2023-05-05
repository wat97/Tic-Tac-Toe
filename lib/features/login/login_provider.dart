import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../router/router.dart';
import '../../models/models.dart';
import '../../widget/widget.dart';
import '../../services/services.dart';

class LoginProvider extends CustomCore {
  String cobaExtras;
  LoginProvider(this.cobaExtras);
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  // int maxWidth = 3;
  // int conditionWin = 3;
  // Player? winnerPlayer;
  // List<Cell> answerTicTacToe = [];
  // List<Cell> boardTicTacToe = [];
  Player current_player = Player.playerX;

  late GameService gameService;

  @override
  void onInit(
    BuildContext context, {
    String? tag,
  }) async {
    super.onInit(context, tag: tag);

    gameService = GameService(
      maxWidth: 4,
      conditionWinner: 3,
      currentPlayer: current_player,
    );
    gameService.setRefresh = () {
      notifyListeners();
    };
    gameService.createBoard();
    // initBoard();
    // notifyListeners();
  }

  goLogin() {
    contextCore.go(
      RouterNavigation.routedashboard,
    );
  }

  // initBoard() {
  //   for (var i = 0; i < maxWidth; i++) {
  //     for (var j = 0; j < maxWidth; j++) {
  //       Cell cell = Cell(i, j);
  //       boardTicTacToe.add(cell);
  //     }
  //   }
  // }

  onClickTic(Cell cell) {
    gameService.logicClick(
      currentPlayer: current_player,
      clickedCell: cell,
    );
    current_player = gameService.currentPlayer;
    var player = gameService.winnerPlayer;
    print("winneran ${player}");
    // var tempCell = boardTicTacToe.indexWhere((element) {
    //   // if (element == Cell && element.currentPlayer == null) {
    //   //   return true;
    //   // }
    //   return element == Cell && element.currentPlayer == null;
    // });
    // print("tempCell ${tempCell}");
    // if (tempCell >= 0) {
    //   // var modelCell = tempCell.length == 1 ? tempCell.elementAt(0) : null;
    //   // if (modelCell != null) {
    //   cell.currentPlayer = current_player;
    //   boardTicTacToe.elementAt(tempCell).currentPlayer = current_player;
    //   // answerTicTacToe.add(Cell);
    //   current_player =
    //       current_player == Player.playerX ? Player.playerO : Player.playerX;
    //   // }
    //   // print(
    //   //     "onClick ${Cell.toJson()} | ${DateTime.now()} | ${Cell.currentPlayer}");
    //   // checkWinner();
    //   notifyListeners();
    // }
    // winnerPlayer = checkWinner();
    // if (winnerPlayer != null) {
    //   print("Selamat Player $winnerPlayer adalah pemenang");
    //   BasicDialogState().showDialogMessage(this.contextCore, true,
    //       msg: "Selamat Player $winnerPlayer adalah pemenang");
    //   // BasicDialog().
    //   // BasicDialog.(
    //   //   context,
    //   //   false,
    //   //   buttonText: 'OK',
    //   //   msg: result.errMsg,
    //   //   onPress: () async {
    //   //     Navigator.pop(context);
    //   //   },
    //   // );
    // }
    // notifyListeners();
  }

  // Cell processCell(Cell cell) {
  //   var tempCell = boardTicTacToe.where((element) => element == cell).toList();
  //   if (tempCell.isNotEmpty) {
  //     return tempCell.first;
  //   }
  //   return cell;
  // }

  // Player? checkWinner() {
  //   int iteratewin = 1;
  //   Player? playerWin;
  //   for (var element in boardTicTacToe) {
  //     // check condition player
  //     iteratewin = 1;
  //     print("checkWinner ${element}, |${boardTicTacToe.length}|");
  //     for (final line in getValidLines(element, boardTicTacToe)) {
  //       print("lineChecking ${line}");
  //       for (var rowLine in line) {
  //         print("Counting Player ${playerWin} , $iteratewin");
  //         if (playerWin == rowLine.currentPlayer) {
  //           iteratewin++;
  //           if (iteratewin == conditionWin) {
  //             return playerWin;
  //           }
  //         } else {
  //           iteratewin = 1;
  //           playerWin = rowLine.currentPlayer;
  //         }
  //       }
  //     }
  //   }
  // }

  // Iterable<List<Cell>> getValidLines(Cell cell, List<Cell> boardCell) sync* {
  //   // Vertikal Lines
  //   outerloop:
  //   for (var startCol = cell.x - maxWidth + 1; startCol <= cell.x; startCol++) {
  //     final startCoordinate = Cell(startCol, cell.y);
  //     // print("getValidLines startCoordinates ${startCoordinate}");
  //     if (!startCoordinate.isValid(
  //       maxX: maxWidth,
  //       maxY: maxWidth,
  //     )) continue;
  //     final endCoordinate = Cell(startCoordinate.x + maxWidth - 1, cell.y);
  //     // print("getValidLines endCoordinate ${endCoordinate}");
  //     if (!endCoordinate.isValid(
  //       maxX: maxWidth,
  //       maxY: maxWidth,
  //     )) continue;
  //     List<Cell> iterateCell = [];

  //     for (var i = startCoordinate.x; i <= endCoordinate.x; i++) {
  //       Cell cellTemp =
  //           boardTicTacToe.firstWhere((element) => element == Cell(i, cell.y));
  //       iterateCell.add(cellTemp);
  //       if (cellTemp.currentPlayer == null) break outerloop;
  //     }
  //     print("getValidLines vertical ${iterateCell}");
  //     yield iterateCell;
  //   }

  //   print("horizontal Line");

  //   // Horizontal Lines
  //   outerloop:
  //   for (var startRow = cell.y - maxWidth + 1; startRow <= cell.y; startRow++) {
  //     final startCoordinate = Cell(cell.x, startRow);
  //     print("getValidLines horizontal startCoordinates ${startCoordinate}");
  //     if (!startCoordinate.isValid(
  //       maxX: maxWidth,
  //       maxY: maxWidth,
  //     )) continue;
  //     final endCoordinate = Cell(cell.x, startCoordinate.y + maxWidth - 1);
  //     if (!endCoordinate.isValid(
  //       maxX: maxWidth,
  //       maxY: maxWidth,
  //     )) continue;
  //     List<Cell> iterateCell = [];
  //     for (var i = startCoordinate.y; i <= endCoordinate.y; i++) {
  //       Cell cellTemp =
  //           boardTicTacToe.firstWhere((element) => element == Cell(cell.x, i));
  //       iterateCell.add(cellTemp);
  //       if (cellTemp.currentPlayer == null) break outerloop;
  //     }
  //     print("getValidLines horizontal ${iterateCell}");
  //     yield iterateCell;
  //   }

  //   // down ward diagonal
  //   outerloop:
  //   for (var colOffset = -maxWidth + 1; colOffset <= 0; colOffset++) {
  //     var rowOffset = colOffset;
  //     final startCoordinate = Cell(cell.x + colOffset, cell.y + rowOffset);
  //     print("downWard Start ${startCoordinate}");
  //     if (!startCoordinate.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
  //     final endCoordinate = Cell(
  //         startCoordinate.x + maxWidth - 1, startCoordinate.y + maxWidth - 1);
  //     if (!endCoordinate.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
  //     List<Cell> iterateCell = [];
  //     for (var i = 0; i < maxWidth; i++) {
  //       Cell cellTemp = boardTicTacToe.firstWhere((element) =>
  //           element == Cell(startCoordinate.x + i, startCoordinate.y + i));
  //       iterateCell.add(cellTemp);
  //       if (cellTemp.currentPlayer == null) break outerloop;
  //     }
  //     print("downWard ${iterateCell}");
  //     yield iterateCell;
  //   }

  //   // Up ward diagonal
  //   outerloop:
  //   for (var colOffset = -maxWidth + 1; colOffset <= 0; colOffset++) {
  //     var rowOffset = -colOffset;
  //     final startCoordinate = Cell(cell.x + colOffset, cell.y + rowOffset);
  //     print("upWard Start ${startCoordinate}");
  //     if (!startCoordinate.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
  //     final endCoordinate = Cell(
  //         startCoordinate.x + maxWidth - 1, startCoordinate.y - maxWidth + 1);
  //     if (!endCoordinate.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
  //     List<Cell> iterateCell = [];
  //     for (var i = 0; i < maxWidth; i++) {
  //       Cell cellTemp = boardTicTacToe.firstWhere((element) =>
  //           element == Cell(startCoordinate.x + i, startCoordinate.y - i));
  //       iterateCell.add(cellTemp);
  //       if (cellTemp.currentPlayer == null) break outerloop;
  //     }
  //     print("upWard ${iterateCell}");
  //     yield iterateCell;
  //   }
  // }
}
