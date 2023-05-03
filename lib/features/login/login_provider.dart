import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template_provider/models/model_cell_cordinate.dart';

import '../../core/core.dart';
import '../../router/router.dart';

class LoginProvider extends CustomCore {
  String cobaExtras;
  LoginProvider(this.cobaExtras);
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  int maxWidth = 3;
  int conditionWin = 3;
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
    checkWinner();
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

  checkWinner() async {
    for (var element in boardTicTacToe) {
      // check condition player
      if (element.currentPlayer == Player.playerX) {
        for (final line in getValidLines(element)) {
          line.forEach((element) {
            print("lineWinneran ${element.toJson()}");
          });
          var enemy =
              line.where((element) => element.currentPlayer == Player.playerO);
          var human =
              line.where((element) => element.currentPlayer == Player.playerX);
          print("lineWinner ${line}, $enemy, $human");
        }
        // print("element ${element.toJson()}, ${lines}");
      }
    }
    print("Winner");
    notifyListeners();
  }

  Iterable<List<CellCordinate>> getValidLines(
      CellCordinate cellCordinate) sync* {
    for (var startCol = cellCordinate.col - maxWidth + 1;
        startCol <= cellCordinate.col;
        startCol++) {
      final startCoordinate = CellCordinate(startCol, cellCordinate.row);
      // print("getValidLines startCoordinates ${startCoordinate}");
      if (!startCoordinate.isValid(
        maxCol: maxWidth,
        maxRow: maxWidth,
      )) continue;
      final endCoordinate =
          CellCordinate(startCoordinate.col + maxWidth - 1, cellCordinate.row);
      // print("getValidLines endCoordinate ${endCoordinate}");
      if (!endCoordinate.isValid(
        maxCol: maxWidth,
        maxRow: maxWidth,
      )) continue;
      print("getValidLines yield, ${cellCordinate.toJson()}");
      yield [
        for (var i = startCoordinate.col; i <= endCoordinate.col; i++)
          CellCordinate(i, cellCordinate.row)
      ];
    }
  }
}
