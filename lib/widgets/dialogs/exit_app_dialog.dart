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
            "Exit app",
            style: TextStyle(fontSize: 20),
          ),
          content: Text("Do you really want to exit the app?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context, false),
            ),
            SizedBox(width: 4,),
            ElevatedButton(
              child: const Text("Exit"),
              onPressed: () => Navigator.pop(context, true),
            ),

            SizedBox(width: 8,),

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
