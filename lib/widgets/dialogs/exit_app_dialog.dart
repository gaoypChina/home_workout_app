import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> exitAppDialog({required BuildContext context}) async {
  bool value = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              title: Text(
                "Do you really want to exit the app?",
                style: TextStyle(fontSize: 18, letterSpacing: 1.5),
              ),
              actions: [

                TextButton(
                  child: const Text("Yes"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                ElevatedButton(
                  child: const Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                SizedBox(width: 12,)
              ],
            );
          }) ??
      false;

  if (value) {
    SystemNavigator.pop();
    return true;
  } else {
    return false;
  }
}
