import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  final Color colorBackground;
  final Color colorText;
  const AppBarCustom({
    super.key,
    required this.title,
    required this.colorBackground,
    required this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: colorBackground,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: colorText,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
