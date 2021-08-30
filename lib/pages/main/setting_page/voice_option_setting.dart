//TODO: uncomment all

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

class ConfirmVoiceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Did you hear the test voice?",
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
    return AlertDialog(
      title: Text("Open TTS Setting"),
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
