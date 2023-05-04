import 'package:flutter/material.dart';

import '../widget.dart';

class BasicDialog extends StatefulWidget {
  const BasicDialog({super.key});

  @override
  State<BasicDialog> createState() => _BasicDialogState();
}

class _BasicDialogState extends State<BasicDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: 10,
        height: 120,
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: const Text("Loading ...",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        height: 1.5,
                        fontWeight: FontWeight.w200)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDialogMessage(
    BuildContext context,
    bool status, {
    String? title,
    required String msg,
    String? buttonText,
    Function? onPress,
    bool? useImage,
  }) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: EdgeInsets.all(15),
          child: Container(
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: status ? Colors.grey : Colors.red,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Wrap(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          useImage == null
                              ? Icon(
                                  status ? Icons.check : Icons.error,
                                  size: 50,
                                  color: status ? Colors.grey : Colors.red,
                                )
                              : Container(),
                          SizedBox(
                            height: 5,
                          ),
                          title == null
                              ? Container()
                              : Text(
                                  title,
                                  textAlign: TextAlign.center,
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            msg,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 200,
                              height: 35,
                              child: status
                                  ? BasicButton(
                                      title: buttonText == null
                                          ? 'Tutup'
                                          : buttonText,
                                      onPressed: () {
                                        if (onPress != null) {
                                          onPress();
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                    )
                                  : BasicButton(
                                      title: buttonText == null
                                          ? 'Tutup'
                                          : buttonText,
                                      onPressed: () {
                                        if (onPress != null) {
                                          onPress();
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                    )),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
