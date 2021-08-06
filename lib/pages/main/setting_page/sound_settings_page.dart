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
  bool showSaveButton = false;

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
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    getSwitch(String title, IconData icon, bool value, Function onToggle,
        String subTile,Color color) {
      return SwitchListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        subtitle: Text(subTile),
        value: value,
        secondary:
        Icon(icon,color: color,),
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

    List<Color> colorList = [Colors.green,Colors.red,Colors.orange,Colors.purpleAccent,];

    getDivider(){
      return
        //Divider(color: Colors.grey,indent: 50,endIndent: 20,);
        Container(
        width: MediaQuery.of(context).size.width,
        height: .0,
        color: Colors.grey,padding: EdgeInsets.only(left: 20,right: 20),);

    }

    return Scaffold(
      backgroundColor: isDark?Colors.black:Colors.white,
      appBar: AppBar(
        backgroundColor: isDark?Colors.black:Colors.white,

        actions: [
         showSaveButton? Padding(
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
                      color: Colors.blue.shade700,
                    ))),
          ):Container()
        ],
        title: Text(
          "Sound Setting",
          style:TextStyle(color: isDark?Colors.white:Colors.black)
        ),
      ),
      body: ListView(

        padding: EdgeInsets.only(top: 8),
        shrinkWrap: true,
        children: [
          getSwitch(
              "Mute", Icons.volume_up, mute, onMuteToggle, "Mute all Sound",colorList[0]),

          getDivider(),
          getSwitch("Coach Assistant", Icons.record_voice_over, coach,
              onCoachToggle, "Coach Assistant " + getSwitchValue(coach),colorList[1]),

          getDivider(),

          getSwitch("Voice Guid", MaterialCommunityIcons.speaker_wireless,
              voice, onVoiceToggle, "Voice Guid " + getSwitchValue(voice),colorList[2]),

          getDivider(),

          getSwitch("Sound Effect", MaterialCommunityIcons.bell, effect,
              onEffectToggle, "Sound Effect " + getSwitchValue(effect),colorList[3]),

          getDivider(),
        ],
      ),

    );
  }
}
