import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isSecure;
  final bool isCenter;
  final bool isEnable;
  final Function? onChange;

  const InputText(
    this.hint,
    this.controller,
    this.inputType, {
    super.key,
    this.isSecure = false,
    this.isCenter = false,
    this.isEnable = true,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withAlpha(90),
          width: 0.8,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                if (onChange != null) {
                  onChange!(value);
                }
              },
              enabled: isEnable,
              textAlign: isCenter ? TextAlign.center : TextAlign.start,
              minLines: 1,
              maxLines: 1,
              obscureText: isSecure ? true : false,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: inputType,
              textInputAction: TextInputAction.done,
              controller: controller,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: hint,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
