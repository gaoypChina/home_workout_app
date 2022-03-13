import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';

class ResetProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SpKey spKey = SpKey();
    SpHelper spHelper = SpHelper();
    Constants constants = Constants();
    return CupertinoAlertDialog(

      title: Text("Do you want to reset your workout progress?",style: TextStyle(fontSize: 15,letterSpacing: 1.20),),

      actions: [

        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("No")),
        TextButton(
            onPressed: () async {
              await spHelper.saveInt(spKey.fullBodyChallenge, 0);
              await spHelper.saveInt(spKey.absChallenge, 0);
              await spHelper.saveInt(spKey.armChallenge, 0);
              await spHelper.saveInt(spKey.chestChallenge, 0);

              constants.getToast("Progress Reset Successfully");

              Navigator.of(context).pop();

            },
            child: Text("Yes")),

      ],
    );
  }
}
