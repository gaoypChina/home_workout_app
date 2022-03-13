//TODO: uncomment all

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmVoiceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        "Did you hear the test voice?",
        style: TextStyle(fontSize: 16,letterSpacing: 1.3),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, false), child: Text("No")),
        TextButton(
            onPressed: () => Navigator.pop(context, true), child: Text("Yes")),
      ],
    );
  }
}

class OpenDeviceTTSSettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Open TTS Setting",
        style: TextStyle(fontSize: 16,letterSpacing: 1.3),),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("No")),
        TextButton(
            onPressed: () async {
              try{
                AndroidIntent intent = AndroidIntent(
                  action: 'com.android.settings.TTS_SETTINGS',
                );
                await intent.launch();
              }catch(e){

              }
              Navigator.of(context).pop();
            },
            child: Text("Yes")),
      ],
    );
  }
}
