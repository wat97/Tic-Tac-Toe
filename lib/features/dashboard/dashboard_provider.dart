import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/core.dart';
import '../../router/router.dart';

class DashboardProvider extends CustomCore {
  @override
  void onInit(BuildContext context, {String? tag}) {
    // TODO: implement onInit
    super.onInit(context, tag: tag);
  }

  getData() async {}

  goToPlanner() async {
    contextCore.push(
      RouterNavigation.routeplangeneral,
    );
  }
}
