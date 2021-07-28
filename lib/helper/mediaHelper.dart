import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';

class MediaHelper {
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  FlutterTts flutterTts = FlutterTts();
  Audio audio;
  Future playSoundOnce(String audioPath) async {
    bool effect = await spHelper.loadBool(spKey.effect);
    print(effect);
    print("sound effect : " + effect.toString());
    if (effect) {
      audio = Audio.load(audioPath);
      audio
        ..play()
        ..dispose();
    }
  }

  Future speak(String text) async {

    bool effect = await spHelper.loadBool(spKey.effect);
    print(effect);

    print("speak effect : " + effect.toString());

    if(effect){
      await flutterTts.setPitch(1);
      await flutterTts.speak(text);
    }
  }

  Future<List<String>> getLang() async {
    List<String> langList = [];
    await flutterTts.getLanguages.then((value) => langList.add(value));
    return langList;
  }


  Future dispose() async{
    await audio.dispose();
    await flutterTts.stop();
  }

}


class RestMediaHelper {
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  FlutterTts flutterTts = FlutterTts();
  Audio audio;
  Future playSoundOnce(String audioPath) async {
    bool effect = await spHelper.loadBool(spKey.effect);
    print(effect);
    print("sound effect : " + effect.toString());
    if (effect) {
      audio = Audio.load(audioPath);
      audio
        ..play()
        ..dispose();
    }
  }

  Future speak(String text) async {

    bool effect = await spHelper.loadBool(spKey.effect);
    print(effect);

    print("speak effect : " + effect.toString());

    if(effect){
      await flutterTts.setPitch(1);
      await flutterTts.speak(text);
    }
  }

  Future<List<String>> getLang() async {
    List<String> langList = [];
    await flutterTts.getLanguages.then((value) => langList.add(value));
    return langList;
  }


  Future dispose() async{
    await audio.dispose();
    await flutterTts.stop();
  }

}