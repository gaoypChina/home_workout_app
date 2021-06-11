import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';

class SoundOption extends StatefulWidget {
  @override
  _SoundOptionState createState() => _SoundOptionState();
}

class _SoundOptionState extends State<SoundOption> {
  SpHelper spHelper =new SpHelper();
  SpKey spKey =new SpKey();
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
      return Row(
        children: [
          Icon(icon,color: Colors.grey,),
          SizedBox(
            width: 10,
          ),
          Text(title),
          Spacer(),
          Switch(
            value: value,
            onChanged: (newVal) => onToggle(newVal),
          ),
        ],
      );
    }

    return AlertDialog(
      title: Text("Sound Setting"),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 20.0, 4.0),
      content: ListView(
        shrinkWrap: true,
        children: [
          getSwitch("Mute", Icons.volume_up, mute, onMuteToggle),
          getSwitch(
              "Coach Assistant", Icons.record_voice_over, coach, onCoachToggle),
          getSwitch("Voice Guid", MaterialCommunityIcons.speaker_wireless,
              voice, onVoiceToggle),
          getSwitch("Sound Effect", MaterialCommunityIcons.bell, effect,
              onEffectToggle)
        ],
      ),
      actions: [
        TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Save")),
      ],
    );
  }
}
