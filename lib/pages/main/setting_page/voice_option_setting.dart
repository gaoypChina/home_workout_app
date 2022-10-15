import 'package:android_intent_plus/android_intent.dart';

import 'package:flutter/material.dart';
import '../../../../constants/constant.dart';

class ConfirmVoiceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Did you hear the test voice?",
        style: TextStyle(fontSize: 16, letterSpacing: 1.3),
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context, false), child: Text("No")),
        ElevatedButton(
            onPressed: () => Navigator.pop(context, true), child: Text("Yes")),
        SizedBox(width: 8,)
      ],
    );
  }
}

class OpenDeviceTTSSettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Open TTS Setting?",
        style: TextStyle(fontSize: 16, letterSpacing: 1.3),
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("No")),
        ElevatedButton(
            onPressed: () async {
              try {
                AndroidIntent intent = AndroidIntent(
                  action: 'com.android.settings.TTS_SETTINGS',
                );
                await intent.launch();
              } catch (e) {
                Constants().getToast("Open TTS setting from device setting");
              }
              Navigator.of(context).pop();
            },
            child: Text("Yes")),
      ],
    );
  }
}
