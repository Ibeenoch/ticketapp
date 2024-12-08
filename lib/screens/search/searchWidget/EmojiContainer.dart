import 'package:flutter/material.dart';

class Emojicontainer extends StatelessWidget {
  const Emojicontainer({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 30,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ));
  }
}
