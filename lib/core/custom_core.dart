import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'interface_core.dart';
import 'provider_core.dart';

class CustomCore extends ProviderCore implements InterfaceCore {
  late BuildContext contextCore;
  late String tagCore;
  late Size size;
  @override
  void onInit(
    BuildContext context, {
    String? tag = "CustomCore",
  }) {
    contextCore = context;
    tagCore = tag!;
    size = MediaQuery.of(context).size;
    debugPrint("CustomCore Tag: $tagCore");
  }

  @override
  void showLoadingProgress(int value, int total) {}

  logOut() {
    Phoenix.rebirth(contextCore);
  }
}
