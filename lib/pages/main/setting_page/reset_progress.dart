import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';

class ResetProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    SpKey spKey = SpKey();
    SpHelper spHelper = SpHelper();
    Constants constants = Constants();
    return AlertDialog(
      content: Text("Do you want to reset progress"),
      actions: [
        TextButton(
            onPressed: () async {
              await spHelper.saveInt(spKey.fullBodyChallenge, 0);
              await spHelper.saveInt(spKey.absChallenge, 0);
              await spHelper.saveInt(spKey.armChallenge, 0);
              await spHelper.saveInt(spKey.chestChallenge, 0);
              
              constants.getToast("Progress Reset Successfully",isDark);

              Navigator.of(context).pop();
              
            },
            child: Text("Yes")),
        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("No")),
      ],
    );
  }
}
