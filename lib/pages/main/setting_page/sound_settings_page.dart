import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';

class SoundSetting extends StatefulWidget {
  static const routeName = "sound-settings-screen";
  @override
  _SoundSettingState createState() => _SoundSettingState();
}

class _SoundSettingState extends State<SoundSetting> {
  SpHelper spHelper =new SpHelper();
  SpKey spKey =new SpKey();
  Constants constants = Constants();
  bool mute;
  bool voice;
  bool coach;
  bool effect;

  @override
  void initState() {
    print("$mute, $voice, $coach $effect");
    intiValue();
    setState(() {

    });
    super.initState();
  }

  intiValue() async {
    mute = await spHelper.loadBool(spKey.mute);
    voice = await spHelper.loadBool(spKey.voice);
    coach = await spHelper.loadBool(spKey.coach);
    effect = await spHelper.loadBool(spKey.effect);

    print("$mute, $voice, $coach $effect");


    mute = mute == null ? false : mute;
    voice = voice == null ? true : voice;
    coach = coach == null ? true : coach;
    effect = effect == null ? true : effect;
    setState(() {});
  }

  onMuteToggle(bool value) {
    setState(() {
      mute = value;
      voice = false;
      coach = false;
      effect = false;
    });
  }

  onVoiceToggle(bool value) async{
    setState(() {
      voice = value;
      mute = false;
    });
  }

  onCoachToggle(bool value) {
    setState(() {
      coach = value;
      mute = false;
    });
  }

  onEffectToggle(bool value) {
    setState(() {
      effect = value;
      mute = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getSwitch(String title, IconData icon, bool value, Function onToggle,
        String subTile) {
      return Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        elevation: 2,
        child: SwitchListTile(
          subtitle: Text(subTile),
          value: value,
          tileColor: constants.tileColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          secondary: CircleAvatar(
            child: Icon(icon),
          ),
          title: Text(
            title,
            style: constants.contentTextStyle.copyWith(fontSize: 16),
          ),
          onChanged: (newVal) => onToggle(newVal),
        ),
      );
    }

    getSwitchValue(bool val) {
      return val ? "On" : "Off";
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                spHelper.saveBool(spKey.mute, mute);
                spHelper.saveBool(spKey.coach, coach);
                spHelper.saveBool(spKey.voice, voice);
                spHelper.saveBool(spKey.effect, effect);
                Navigator.of(context).pop();
                constants.getToast("Sound Settings Saved");
              },
              child: Text("Save",
                  style: TextStyle(
                    color: constants.appBarContentColor,
                  )))
        ],
        title: Text(
          "Sound Setting",
          style: TextStyle(color: constants.appBarContentColor),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        shrinkWrap: true,
        children: [
          getSwitch(
              "Mute", Icons.volume_up, mute, onMuteToggle, "Mute all Sound"),
          SizedBox(
            height: 10,
          ),
          getSwitch("Coach Assistant", Icons.record_voice_over, coach,
              onCoachToggle, "Coach Assistant " + getSwitchValue(coach)),
          SizedBox(
            height: 10,
          ),
          getSwitch("Voice Guid", MaterialCommunityIcons.speaker_wireless,
              voice, onVoiceToggle, "Voice Guid " + getSwitchValue(voice)),
          SizedBox(
            height: 10,
          ),
          getSwitch("Sound Effect", MaterialCommunityIcons.bell, effect,
              onEffectToggle, "Sound Effect " + getSwitchValue(effect))
        ],
      ),

    );
  }
}
