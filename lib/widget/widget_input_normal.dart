import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextNormal extends StatelessWidget {
  final String hint;
  final String? label;
  final TextEditingController controller;
  final TextInputType inputType;
  final Function? onChange;
  bool floatingText = true;
  bool? enabled = true;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  InputTextNormal(
    this.hint,
    this.controller,
    this.inputType, {
    super.key,
    this.onChange,
    this.floatingText = true,
    this.label,
    this.enabled,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        enabled: enabled,
        keyboardType: inputType,
        controller: controller,
        onChanged: (value) {
          if (onChange != null) {
            onChange!(value);
          }
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label ?? "",
          hintText: hint,
          fillColor: Colors.white,
          filled: true,
          floatingLabelBehavior: floatingText
              ? FloatingLabelBehavior.auto
              : FloatingLabelBehavior.never,
        ),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
