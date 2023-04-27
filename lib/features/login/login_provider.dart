import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../router/router.dart';

class LoginProvider extends CustomCore {
  String cobaExtras;
  LoginProvider(this.cobaExtras);
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  int maxRow = 4;

  @override
  void onInit(
    BuildContext context, {
    String? tag,
  }) {
    super.onInit(context, tag: tag);
    notifyListeners();
  }

  goLogin() {
    contextCore.go(
      RouterNavigation.routedashboard,
    );
  }
}
