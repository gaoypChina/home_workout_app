import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../helper/sp_helper.dart';
import '../helper/sp_key_helper.dart';
import 'package:text_to_speech/text_to_speech.dart';

class MediaHelper {
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  FlutterTts flutterTts = FlutterTts();
  TextToSpeech tts = TextToSpeech();

  late final Audio audio;
  Future playSoundOnce(String audioPath) async {
    bool effect = await spHelper.loadBool(spKey.effect) ?? true;
    print(effect);
    if (effect) {
      audio = Audio.load(audioPath);
      audio
        ..play()
        ..dispose();
    }
  }

  Future speak(String text) async {
    bool voice = await spHelper.loadBool(spKey.voice) ?? true;
    bool coach = await spHelper.loadBool(spKey.coach) ?? true;
    if (voice || coach) {
      await tts.speak(text);
    }
  }

  Future speakTestVoice(String text) async {
    bool voice = await spHelper.loadBool(spKey.voice) ?? true;
    bool coach = await spHelper.loadBool(spKey.coach) ?? true;
    if (voice || coach) {
      await tts.speak(text);
    }
  }

  Future<List<String>> getLang() async {
    List<String> langList = [];
    await flutterTts.getLanguages.then((value) => langList.add(value));
    return langList;
  }
}
