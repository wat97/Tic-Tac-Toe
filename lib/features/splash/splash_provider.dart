import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/core.dart';
import '../../router/router.dart';

class SplashProvider extends CustomCore {
  bool isLoading = true;
  String textVersion = "";

  @override
  void onInit(
    BuildContext context, {
    String? tag,
  }) {
    super.onInit(context, tag: tag);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint("splash ${DateTime.now()}");
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      var vCurrent =
          int.parse(packageInfo.buildNumber.replaceAll(RegExp(r'[^0-9]'), ''));
      textVersion += "Version ${packageInfo.version}($vCurrent)";
      isLoading = false;
      notifyListeners();
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () {
          debugPrint("splash ${DateTime.now()}");
          context.go(RouterNavigation.routelogin, extra: '123');
        },
      );
    });
  }
}
