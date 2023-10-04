import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts = FlutterTts();

Future<void> speak(String text) async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setPitch(1);
  await flutterTts.setSpeechRate(.6);

  await flutterTts.speak(text);
}
