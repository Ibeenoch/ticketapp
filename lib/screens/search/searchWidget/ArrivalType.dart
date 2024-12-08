import 'package:flutter/material.dart';

class Arrivaltype extends StatelessWidget {
  const Arrivaltype({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Icon(
              // Icons.flight_takeoff,
              icon,
              color: Colors.grey,
              size: 17,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 15, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
