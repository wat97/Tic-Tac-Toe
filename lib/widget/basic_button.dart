import 'package:flutter/material.dart';

import '../resources/resources.dart';

class BasicButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? colorBackground;
  final String title;
  final Color? colorText;
  final double? height;
  final double? width;
  BasicButton({
    super.key,
    this.onPressed,
    required this.title,
    this.colorBackground,
    this.colorText,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: colorBackground ?? MyColors.colorPrimary,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: colorText ?? Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
