import 'package:flutter/material.dart';
import 'package:flutter_word_search/repository/firebase_repo.dart';
import 'package:flutter_word_search/screens/word_detail.dart';

class BuildTableCell extends StatelessWidget {
  final String word;

  final WordRepository _wordRepository = WordRepository();
  BuildTableCell({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _wordRepository.addHistoryToFirestore(word);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WordDetail(word: word)));
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
}
