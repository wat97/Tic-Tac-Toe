import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:template_provider/models/model_cell_cordinate.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: prov.size.width * 0.1),
            child: Column(
              children: getMatrix(
                prov,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  List<Widget> getMatrix(LoginProvider prov) {
    List<Widget> rows = [];
    for (var i = 0; i < prov.maxWidth; i++) {
      rows.add(
        Row(
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
    for (var i = 0; i < prov.maxWidth; i++) {
      column.add(
        generateCell(
          prov,
          CellCordinate(col, i),
        ),

        // Container(
        //   height: prov.size.height * 0.1,
        //   width: prov.size.width * 0.1,
        //   decoration: BoxDecoration(
        //       color: Colors.yellow,
        //       border: Border.all(
        //         color: Colors.black,
        //         width: 5,
        //       )),
        // ),
        // Row(
        //   children: generateRow(
        //     context,
        //     prov,
        //     col: (i - 1),
        //   ),
        // ),
      );
    }
    return column;
  }

  Widget generateCell(LoginProvider prov, CellCordinate cellCordinate) {
    CellCordinate newCell = prov.processCell(cellCordinate);
    return GestureDetector(
      onTap: () => prov.onClickTic(newCell),
      child: SizedBox(
        width: prov.size.width * 0.15,
        height: prov.size.width * 0.15,
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
            left: newCell.row == 0 ? true : false,
            down: newCell.col == (prov.maxWidth - 1) ? true : false,
          ),
          child: Column(
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
                  style: const TextStyle(
                    fontSize: 24,
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
