import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../models/models.dart';
import '../../services/storage/storage.dart';

class PlanGeneralProvider extends CustomCore {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerStartMoney = TextEditingController();
  TextEditingController controllerFinishMoney = TextEditingController();
  TextEditingController controllerStartDate = TextEditingController();
  @override
  void onInit(BuildContext context, {String? tag}) {
    // TODO: implement onInit
    super.onInit(context, tag: tag);
  }

  savePlan() async {
    try {
      ModelPlanGeneral model = ModelPlanGeneral(
        title: controllerTitle.text,
        goalsMoney: int.parse(controllerStartMoney.text),
      );
      await DatabaseHelper.instance.addPlantGeneral(model);
      contextCore.canPop();
    } catch (e) {
      print("catchAdd ${e.toString()}");
    }
  }
}
