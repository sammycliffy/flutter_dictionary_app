import 'package:flutter/material.dart';
import 'package:flutter_word_search/screens/favorite.dart';
import 'package:flutter_word_search/screens/history.dart';
import 'package:flutter_word_search/screens/widget/sizes.dart';
import 'package:flutter_word_search/screens/word_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCellIndex = 0;

  List<Widget> screens = [
    const WordList(),
    const HistoryList(),
    const FavoriteList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpace(30),
              Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      _buildCell(0, "Word list"),
                      _buildCell(1, "History"),
                      _buildCell(2, "Favorites"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Word list",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: screens[selectedCellIndex],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCell(int index, String word) {
    bool isSelected = selectedCellIndex == index;
    return GestureDetector(
      onTap: () => _onCellTap(index),
      child: Container(
        height: 60,
        color: isSelected ? Colors.grey : Colors.white,
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

  void _onCellTap(int index) {
    setState(() {
      selectedCellIndex = index;
    });
  }
}
