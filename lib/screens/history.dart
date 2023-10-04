import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_word_search/providers/providers.dart';
import 'package:flutter_word_search/screens/widget/table_cell.dart';
import 'package:flutter_word_search/utils/extentions/index_of_map.dart';

class HistoryList extends ConsumerStatefulWidget {
  const HistoryList({super.key});

  @override
  ConsumerState<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends ConsumerState<HistoryList> {
  late DocumentReference documentReference;

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
            children: [
              ...wordList.mapIndexed((e, i) => BuildTableCell(word: e))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    final userId = ref.read(token);
    documentReference =
        FirebaseFirestore.instance.collection('history').doc(userId);
  }
}
