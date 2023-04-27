import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../resources/resources.dart';
import '../../widget/widget.dart';
import 'plan_general.dart';

class PlanGeneral extends StatefulWidget {
  const PlanGeneral({super.key});

  @override
  State<PlanGeneral> createState() => _PlanGeneralState();
}

class _PlanGeneralState extends State<PlanGeneral> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlanGeneralProvider>(context, listen: false).onInit(
        context,
        tag: runtimeType.toString(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PlanGeneralProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              AppBarCustom(
                title: "Planner",
                colorBackground: MyColors.colorPrimary,
                colorText: Colors.white,
              ),
              contentPage(context, prov),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentPage(BuildContext context, PlanGeneralProvider prov) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: prov.size.width * 0.05,
          vertical: prov.size.height * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InputTextNormal(
              "Judul Planner",
              prov.controllerTitle,
              TextInputType.name,
              label: "Judul Planner",
              floatingText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputTextNormal(
              "Awal Tabungan",
              prov.controllerStartMoney,
              const TextInputType.numberWithOptions(),
              label: "Awal Tabungan",
              floatingText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputTextNormal(
              "Target Tabungan",
              prov.controllerFinishMoney,
              const TextInputType.numberWithOptions(),
              label: "Target Tabungan",
              floatingText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: BasicButton(
                title: "Simpan",
                height: prov.size.height * 0.1,
                width: prov.size.width * 0.9,
                onPressed: () async => prov.savePlan(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
