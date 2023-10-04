import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_word_search/providers/providers.dart';
import 'package:flutter_word_search/repository/firebase_repo.dart';
import 'package:flutter_word_search/utils/extentions/index_of_map.dart';

class FavoriteList extends ConsumerStatefulWidget {
  const FavoriteList({super.key});

  @override
  ConsumerState<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends ConsumerState<FavoriteList> {
  late DocumentReference documentReference;
  final WordRepository _wordRepository = WordRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: documentReference.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          DocumentSnapshot document = snapshot.data!;

          Map<String, dynamic> words = document.data() as Map<String, dynamic>;
          List<dynamic> wordList = words["words"];

          log(wordList.toString());

          log(words.toString());

          return Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [...wordList.mapIndexed((e, i) => _buildCell(e))],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    final userId = ref.read(token);
    documentReference =
        FirebaseFirestore.instance.collection('favorite').doc(userId);
  }

  _buildCell(String word) => GestureDetector(
        onTap: () {
          _wordRepository.removeWordFromFirestore(word);
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          height: 60,
          width: 100,
          child: Center(
            child: Text(
              word,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
}
