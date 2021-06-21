import 'package:flutter/material.dart';
import 'package:full_workout/helper/text_to_speech.dart';

class SoundSettingsScreen extends StatefulWidget {
  static const routeName = "sound-settings-screen";

  @override
  _SoundSettingsScreenState createState() => _SoundSettingsScreenState();
}

class _SoundSettingsScreenState extends State<SoundSettingsScreen> {
  Speaker _speaker = Speaker();
  List<String> langList = [];

  getLanguage() async {
    await _speaker.getLang().then((value) => langList = value);
  }

  @override
  void initState() {
    getLanguage();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        child: ListView.builder(
            itemCount: langList.length,
            itemBuilder: (context, index) {
              return Container(
                child: Text(langList[index]),
              );
            }),
      ),
    );
  }
}
