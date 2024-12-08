import 'package:flutter/material.dart';

class RoundedDot extends StatelessWidget {
  const RoundedDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
