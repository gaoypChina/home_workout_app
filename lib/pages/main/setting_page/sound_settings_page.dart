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
    print("$mute, $voice, $coach $effect");
    super.initState();
  }

  intiValue() async {
    mute = await spHelper.loadBool(spKey.mute);
    voice = await spHelper.loadBool(spKey.voice);
    coach = await spHelper.loadBool(spKey.coach);
    effect = await spHelper.loadBool(spKey.effect) ;

    mute = mute==null ? false : mute;
    voice = voice == null ? true : voice;
    coach = coach == null ? true : coach;
    effect = effect == null ? true : effect;
  }

  onMuteToggle(bool value) {
    spHelper.saveBool(spKey.mute, value);
    setState(() {
      mute = value;
    });
    if (value) {
      setState(() {
        voice = false;
        coach = false;
        effect = false;
      });
    } else {
      intiValue();
      setState(() {});
    }
  }

  onVoiceToggle(bool value) async{
   await spHelper.saveBool(spKey.voice, value);
    setState(() {
      voice = value;
    });
  }

  onCoachToggle(bool value) {
    spHelper.saveBool(spKey.coach, value);
    setState(() {
      coach = value;
    });
  }

  onEffectToggle(bool value) {
    spHelper.saveBool(spKey.effect, value);
    setState(() {
      effect = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    getSwitch(String title, IconData icon, bool value, Function onToggle) {
      return ListTile(
        tileColor: constants.tileColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: constants.contentTextStyle.copyWith(fontSize: 16),
        ),
        trailing: Switch(
          value: value,
          onChanged: (newVal) => onToggle(newVal),
        ),
      );
    }

    return Scaffold(
      appBar:AppBar(backgroundColor: Colors.white,
        title:Text("Sound Setting",style: TextStyle(color: Colors.black),),leading: TextButton(
        child: Icon(
          Icons.keyboard_backspace_sharp,
          color: Colors.black,
        ),
        onPressed: Navigator.of(context).pop,
      ),) ,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        shrinkWrap: true,
        children: [
          getSwitch("Mute", Icons.volume_up, mute, onMuteToggle),
          SizedBox(height: 10,),
          getSwitch(
              "Coach Assistant", Icons.record_voice_over, coach, onCoachToggle),
          SizedBox(height: 10,),
          getSwitch("Voice Guid", MaterialCommunityIcons.speaker_wireless,
              voice, onVoiceToggle),
          SizedBox(height: 10,),
          getSwitch("Sound Effect", MaterialCommunityIcons.bell, effect,
              onEffectToggle)
        ],
      ),

    );
  }
}
