import 'package:flutter/material.dart';

abstract class ProviderCore with ChangeNotifier {
  void onInit(
    BuildContext context, {
    String tag = "CustomCore",
  });
}
