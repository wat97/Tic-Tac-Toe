import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template_provider/models/model_cell_cordinate.dart';
import 'package:template_provider/widget/widget.dart';

import '../../core/core.dart';
import '../../router/router.dart';

class LoginProvider extends CustomCore {
  String cobaExtras;
  LoginProvider(this.cobaExtras);
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  int maxWidth = 3;
  int conditionWin = 3;
  Player? winnerPlayer;
  // List<CellCordinate> answerTicTacToe = [];
  List<CellCordinate> boardTicTacToe = [];
  Player current_player = Player.playerX;

  @override
  void onInit(
    BuildContext context, {
    String? tag,
  }) {
    super.onInit(context, tag: tag);
    initBoard();
    notifyListeners();
  }

  goLogin() {
    contextCore.go(
      RouterNavigation.routedashboard,
    );
  }

  initBoard() {
    for (var i = 0; i < maxWidth; i++) {
      for (var j = 0; j < maxWidth; j++) {
        CellCordinate cellCordinate = CellCordinate(i, j);
        boardTicTacToe.add(cellCordinate);
      }
    }
  }

  onClickTic(CellCordinate cellCordinate) {
    var tempCell = boardTicTacToe.indexWhere((element) {
      // if (element == cellCordinate && element.currentPlayer == null) {
      //   return true;
      // }
      return element == cellCordinate && element.currentPlayer == null;
    });
    print("tempCell ${tempCell}");
    if (tempCell >= 0) {
      // var modelCell = tempCell.length == 1 ? tempCell.elementAt(0) : null;
      // if (modelCell != null) {
      cellCordinate.currentPlayer = current_player;
      boardTicTacToe.elementAt(tempCell).currentPlayer = current_player;
      // answerTicTacToe.add(cellCordinate);
      current_player =
          current_player == Player.playerX ? Player.playerO : Player.playerX;
      // }
      // print(
      //     "onClick ${cellCordinate.toJson()} | ${DateTime.now()} | ${cellCordinate.currentPlayer}");
      // checkWinner();
      notifyListeners();
    }
    winnerPlayer = checkWinner();
    if (winnerPlayer != null) {
      print("Selamat Player $winnerPlayer adalah pemenang");
      // BasicDialog().
      // BasicDialog.(
      //   context,
      //   false,
      //   buttonText: 'OK',
      //   msg: result.errMsg,
      //   onPress: () async {
      //     Navigator.pop(context);
      //   },
      // );
    }
    notifyListeners();
  }

  CellCordinate processCell(CellCordinate cellCordinate) {
    var tempCell =
        boardTicTacToe.where((element) => element == cellCordinate).toList();
    if (tempCell.isNotEmpty) {
      return tempCell.first;
    }
    return cellCordinate;
  }

  Player? checkWinner() {
    int iteratewin = 1;
    Player? playerWin;
    for (var element in boardTicTacToe) {
      // check condition player
      iteratewin = 1;
      print("checkWinner ${element}, |${boardTicTacToe.length}|");
      for (final line in getValidLines(element, boardTicTacToe)) {
        print("lineChecking ${line}");
        for (var rowLine in line) {
          print("Counting Player ${playerWin} , $iteratewin");
          if (playerWin == rowLine.currentPlayer) {
            iteratewin++;
            if (iteratewin == conditionWin) {
              return playerWin;
            }
          } else {
            iteratewin = 1;
            playerWin = rowLine.currentPlayer;
          }
        }
      }
    }
  }

  Iterable<List<CellCordinate>> getValidLines(
      CellCordinate cellCordinate, List<CellCordinate> boardCell) sync* {
    // Vertikal Lines
    outerloop:
    for (var startCol = cellCordinate.x - maxWidth + 1;
        startCol <= cellCordinate.x;
        startCol++) {
      final startCoordinate = CellCordinate(startCol, cellCordinate.y);
      // print("getValidLines startCoordinates ${startCoordinate}");
      if (!startCoordinate.isValid(
        maxX: maxWidth,
        maxY: maxWidth,
      )) continue;
      final endCoordinate =
          CellCordinate(startCoordinate.x + maxWidth - 1, cellCordinate.y);
      // print("getValidLines endCoordinate ${endCoordinate}");
      if (!endCoordinate.isValid(
        maxX: maxWidth,
        maxY: maxWidth,
      )) continue;
      List<CellCordinate> iterateCell = [];

      for (var i = startCoordinate.x; i <= endCoordinate.x; i++) {
        CellCordinate cellTemp = boardTicTacToe.firstWhere(
            (element) => element == CellCordinate(i, cellCordinate.y));
        iterateCell.add(cellTemp);
        if (cellTemp.currentPlayer == null) break outerloop;
      }
      print("getValidLines vertical ${iterateCell}");
      yield iterateCell;
    }

    print("horizontal Line");

    // Horizontal Lines
    outerloop:
    for (var startRow = cellCordinate.y - maxWidth + 1;
        startRow <= cellCordinate.y;
        startRow++) {
      final startCoordinate = CellCordinate(cellCordinate.x, startRow);
      print("getValidLines horizontal startCoordinates ${startCoordinate}");
      if (!startCoordinate.isValid(
        maxX: maxWidth,
        maxY: maxWidth,
      )) continue;
      final endCoordinate =
          CellCordinate(cellCordinate.x, startCoordinate.y + maxWidth - 1);
      if (!endCoordinate.isValid(
        maxX: maxWidth,
        maxY: maxWidth,
      )) continue;
      List<CellCordinate> iterateCell = [];
      for (var i = startCoordinate.y; i <= endCoordinate.y; i++) {
        CellCordinate cellTemp = boardTicTacToe.firstWhere(
            (element) => element == CellCordinate(cellCordinate.x, i));
        iterateCell.add(cellTemp);
        if (cellTemp.currentPlayer == null) break outerloop;
      }
      print("getValidLines horizontal ${iterateCell}");
      yield iterateCell;
    }

    // down ward diagonal
    outerloop:
    for (var colOffset = -maxWidth + 1; colOffset <= 0; colOffset++) {
      var rowOffset = colOffset;
      final startCoordinate = CellCordinate(
          cellCordinate.x + colOffset, cellCordinate.y + rowOffset);
      print("downWard Start ${startCoordinate}");
      if (!startCoordinate.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
      final endCoordinate = CellCordinate(
          startCoordinate.x + maxWidth - 1, startCoordinate.y + maxWidth - 1);
      if (!endCoordinate.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
      List<CellCordinate> iterateCell = [];
      for (var i = 0; i < maxWidth; i++) {
        CellCordinate cellTemp = boardTicTacToe.firstWhere((element) =>
            element ==
            CellCordinate(startCoordinate.x + i, startCoordinate.y + i));
        iterateCell.add(cellTemp);
        if (cellTemp.currentPlayer == null) break outerloop;
      }
      print("downWard ${iterateCell}");
      yield iterateCell;
    }

    // Up ward diagonal
    outerloop:
    for (var colOffset = -maxWidth + 1; colOffset <= 0; colOffset++) {
      var rowOffset = -colOffset;
      final startCoordinate = CellCordinate(
          cellCordinate.x + colOffset, cellCordinate.y + rowOffset);
      print("upWard Start ${startCoordinate}");
      if (!startCoordinate.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
      final endCoordinate = CellCordinate(
          startCoordinate.x + maxWidth - 1, startCoordinate.y - maxWidth + 1);
      if (!endCoordinate.isValid(maxX: maxWidth, maxY: maxWidth)) continue;
      List<CellCordinate> iterateCell = [];
      for (var i = 0; i < maxWidth; i++) {
        CellCordinate cellTemp = boardTicTacToe.firstWhere((element) =>
            element ==
            CellCordinate(startCoordinate.x + i, startCoordinate.y - i));
        iterateCell.add(cellTemp);
        if (cellTemp.currentPlayer == null) break outerloop;
      }
      print("upWard ${iterateCell}");
      yield iterateCell;
    }
  }
}
