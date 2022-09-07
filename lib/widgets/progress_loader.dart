import 'package:flutter/material.dart';

class ProgressLoader {
  static showLoadingDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20),
          child: const CircularProgressIndicator(),
        );
      },
    );
  }

  static cancelLoader(context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }
}
