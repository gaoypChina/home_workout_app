import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../helper/sp_helper.dart';
import '../../../helper/sp_key_helper.dart';

class SoundSetting extends StatefulWidget {
  static const routeName = "sound-settings-screen";
  @override
  _SoundSettingState createState() => _SoundSettingState();
}

class _SoundSettingState extends State<SoundSetting> {
  SpHelper spHelper = new SpHelper();
  SpKey spKey = new SpKey();
  Constants constants = Constants();
  bool mute = false;
  bool voice = true;
  bool coach = true;
  bool effect = true;
  bool showSaveButton = false;

  @override
  void initState() {
    intiValue();
    super.initState();
  }

  intiValue() async {
    mute = await spHelper.loadBool(spKey.mute) ?? false;
    voice = await spHelper.loadBool(spKey.voice) ?? true;
    coach = await spHelper.loadBool(spKey.coach) ?? true;
    effect = await spHelper.loadBool(spKey.effect) ?? true;
    setState(() {});
  }

  onMuteToggle(bool value) {
    setState(() {
      mute = value;
      if (value) {
        voice = false;
        coach = false;
        effect = false;
      } else {
        voice = true;
        coach = true;
        effect = true;
      }
    });
  }

  onVoiceToggle(bool value) async {
    setState(() {
      voice = value;
      if (!voice && !coach && !effect) {
        mute = true;
      } else {
        mute = false;
      }
    });
  }

  onCoachToggle(bool value) {
    setState(() {
      coach = value;
      if (!voice && !coach && !effect) {
        mute = true;
      } else {
        mute = false;
      }
    });
  }

  onEffectToggle(bool value) {
    setState(() {
      effect = value;
      if (!voice && !coach && !effect) {
        mute = true;
      } else {
        mute = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getSwitch(String title, IconData icon, bool value, Function onToggle,
        String subTile, Color color) {
      return SwitchListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        subtitle: Text(subTile),
        value: value,
        secondary: Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
        ),
        activeColor: Colors.blue.shade700,
        title: Text(
          title,
          style: constants.listTileTitleStyle.copyWith(fontSize: 16),
        ),
        onChanged: (newVal) {
          showSaveButton = true;
          return onToggle(newVal);
        },
      );
    }

    getSwitchValue(bool val) {
      return val ? "On" : "Off";
    }

    List<Color> colorList = [
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purpleAccent,
    ];

    getDivider() {
      return
          //Divider(color: Colors.grey,indent: 50,endIndent: 20,);
          Container(
              width: MediaQuery.of(context).size.width,
              height: .8,
              color: Colors.grey.withOpacity(.15));
    }

    return Scaffold(
      appBar: AppBar(
          actions: [
            showSaveButton
                ? Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
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
                              color: Theme.of(context).primaryColor,
                            ))),
                  )
                : Container()
          ],
          title: Text(
            "Sound Setting",
          )),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            // color: Colors.orange.withOpacity(.1),
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              children: [
                getSwitch("Mute", Icons.volume_down_outlined, mute,
                    onMuteToggle, "Mute all Sound", colorList[0]),
                getDivider(),
                getSwitch(
                    "Coach Assistant",
                    Icons.record_voice_over_outlined,
                    coach,
                    onCoachToggle,
                    "Coach Assistant " + getSwitchValue(coach),
                    colorList[1]),
                getDivider(),
                getSwitch(
                    "Voice Guid",
                    Icons.volume_up_outlined,
                    voice,
                    onVoiceToggle,
                    "Voice Guid " + getSwitchValue(voice),
                    colorList[2]),
                getDivider(),
                getSwitch(
                    "Sound Effect",
                    Icons.notifications_active_outlined,
                    effect,
                    onEffectToggle,
                    "Sound Effect " + getSwitchValue(effect),
                    colorList[3]),
                getDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
