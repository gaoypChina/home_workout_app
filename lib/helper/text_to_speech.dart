import 'package:flutter_tts/flutter_tts.dart';

class Speaker {
  FlutterTts flutterTts = FlutterTts();

  Future speak(String text) async {
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
    print(flutterTts.getLanguages);
  }

  Future<List<String>> getLang() async {
    List<String> langList = [];
    await flutterTts.getLanguages.then((value) => langList.add(value));
    return langList;
  }

  Future stop() async {
    await flutterTts.stop();
  }
}
