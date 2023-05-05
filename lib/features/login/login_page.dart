import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'login_provider.dart';
import '../../widget/widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginProvider>(context, listen: false).onInit(
        context,
        tag: runtimeType.toString(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<LoginProvider>(context);
    try {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                contentPage(context, prov),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      return Container();
    }
  }

  Widget contentPage(BuildContext context, LoginProvider prov) {
    return Expanded(
      child: Column(
        children: [
          Container(
            child: prov.gameService.boardTicTacToe.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: getMatrix(
                      prov,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget generateMatrix(LoginProvider prov) => Container(
        margin: EdgeInsets.symmetric(
          horizontal: prov.size.width * 0.1,
        ),
      );

  List<Widget> getMatrix(LoginProvider prov) {
    List<Widget> rows = [];
    for (var i = 0; i < prov.gameService.maxWidth; i++) {
      // generate X
      rows.add(
        Column(
          children: generateRow(
            prov,
            col: i,
          ),
        ),
      );
    }
    return rows;
  }

  List<Widget> generateRow(
    LoginProvider prov, {
    int col = 0,
  }) {
    List<Widget> column = [];
    for (var i = 0; i < prov.gameService.maxWidth; i++) {
      column.add(
        generateCell(
          prov,
          Cell(col, i),
        ),
      );
    }
    return column;
  }

  Widget generateCell(LoginProvider prov, Cell cell) {
    Cell newCell = prov.gameService.processCellBoard(cell);
    return GestureDetector(
      onTap: () => prov.gameService.winnerPlayer == null
          ? prov.onClickTic(newCell)
          : null,
      child: SizedBox(
        width: (prov.size.width / prov.gameService.maxWidth) - 10,
        height: (prov.size.width / prov.gameService.maxWidth) - 10,
        child: AnimatedLiner(
          size: const Size(
            double.infinity,
            double.infinity,
          ),
          colorLine: Colors.black,
          thicknessPaint: 5,
          duration: const Duration(
            seconds: 2,
            milliseconds: 200,
          ),
          sidePaint: SidePaint(
            top: true,
            right: true,
            left: newCell.x == 0 ? true : false,
            down: newCell.y == (prov.gameService.maxWidth - 1) ? true : false,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                ),
                child: Text(
                  newCell.coordinateString,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Center(
                child: Text(
                  newCell.getTextPlayer,
                  style: TextStyle(
                    fontSize: (prov.size.width / prov.gameService.maxWidth) -
                        (prov.size.width * 0.15),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
