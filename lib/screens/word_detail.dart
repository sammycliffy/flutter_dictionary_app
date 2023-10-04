import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_word_search/models/word_model.dart';
import 'package:flutter_word_search/repository/firebase_repo.dart';
import 'package:flutter_word_search/repository/word_repo.dart';
import 'package:flutter_word_search/screens/widget/outline_button.dart';
import 'package:flutter_word_search/screens/widget/sizes.dart';
import 'package:flutter_word_search/utils/helpers/tts.dart';

import '../providers/providers.dart';

class WordDetail extends ConsumerStatefulWidget {
  final String word;
  const WordDetail({super.key, required this.word});

  @override
  ConsumerState<WordDetail> createState() => _WordDetailState();
}

class _WordDetailState extends ConsumerState<WordDetail> {
  Duration animationDuration = const Duration(milliseconds: 500);
  final WordRepoCache _wordRepoCached = WordRepoCache();
  final WordRepository _wordRepository = WordRepository();

  late AudioPlayer audioPlayer;

  late Future<WordModel> wordModel;
  double containerAlignment = -1.0;
  double containerWidth = 200;

  @override
  Widget build(BuildContext context) {
    final isAudioPlaying = ref.watch(isPlaying);

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context))),
      body: FutureBuilder<WordModel>(
          future: wordModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String? partOfSpeech = snapshot.data?.meanings?[0].partOfSpeech;
              List<Definitions>? definition =
                  snapshot.data?.meanings?[0].definitions;

              loadUrl(snapshot.data!.phonetics![0].audio!);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightSpace(30),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey[300], border: Border.all()),
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${snapshot.data?.word}",
                                  style: const TextStyle(fontSize: 25)),
                              heightSpace(10),
                              Text("${snapshot.data?.phonetic}",
                                  style: const TextStyle(fontSize: 25))
                            ],
                          ),
                        ),
                        heightSpace(10),
                        Row(children: [
                          isAudioPlaying
                              ? IconButton(
                                  icon: const Icon(Icons.pause, size: 60),
                                  onPressed: () => pause())
                              : IconButton(
                                  icon: const Icon(Icons.play_arrow_outlined,
                                      size: 60),
                                  onPressed: () =>
                                      play("${snapshot.data?.word}")),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200],
                                  ),
                                ),
                                Positioned(
                                  left: containerAlignment * (200 - 15),
                                  child: AnimatedContainer(
                                    width: containerWidth,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue[200],
                                    ),
                                    duration: animationDuration,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        heightSpace(10),
                        const Text("Meanings",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        heightSpace(10),
                        Wrap(
                          children: [
                            Text("$partOfSpeech - ",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                            ...definition!.map((e) => Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Text(e.definition!),
                                ))
                          ],
                        ),
                        heightSpace(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlineButton(
                              text: "Voltar",
                              function: () => Navigator.pop(context),
                            ),
                            OutlineButton(
                              text: "Favorite",
                              function: () => _wordRepository
                                  .addToFavorite(snapshot.data!.word!),
                            ),
                          ],
                        ),
                        heightSpace(50),
                      ]),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  getWordDetails() {
    wordModel = _wordRepoCached.fetchData(widget.word);
  }

  @override
  initState() {
    super.initState();
    getWordDetails();
    audioPlayer = AudioPlayer();
  }

  void loadUrl(String url) async {
    if (url.isEmpty) {
      return;
    }
    await audioPlayer.setSourceUrl(url);
  }

  void moveContainer(double width) {
    setState(() {
      containerWidth = width;
    });
  }

  void pause() async {
    await audioPlayer.pause();
  }

  void play(String word) async {
    if (audioPlayer.source == null) {
      speak(word);
      return;
    }

    await audioPlayer.play(audioPlayer.source!);
    moveContainer(500);
    ref.read(isPlaying.notifier).state = true;
    audioPlayer.onPlayerComplete.listen((event) {
      ref.read(isPlaying.notifier).state = false;
      moveContainer(200);
    });
  }

  void stop() async {
    await audioPlayer.stop();
  }
}
