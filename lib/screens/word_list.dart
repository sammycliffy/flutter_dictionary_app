import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_word_search/screens/widget/table_cell.dart';

class WordList extends StatefulWidget {
  const WordList({super.key});

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  List<dynamic> items = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: BuildTableCell(word: item),
        );
      },
      controller: _scrollController,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreData);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_loadMoreData);
  }

  Future<List<dynamic>> loadJsonData() async {
    final String data = await rootBundle.loadString('assets/words.json');
    final List<dynamic> jsonData = json.decode(data);
    return jsonData.map((json) => json).toList();
  }

  Future<void> _loadData() async {
    final data = await loadJsonData();
    setState(() {
      items = data;
    });
  }

  void _loadMoreData() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      log("reached here");
    }
  }
}
