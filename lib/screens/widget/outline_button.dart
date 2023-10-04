import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  final Function() function;
  const OutlineButton({super.key, required this.function, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
          decoration: BoxDecoration(border: Border.all()),
          width: 150,
          height: 45,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          )),
    );
  }
}
