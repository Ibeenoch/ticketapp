import 'package:flutter/material.dart';

class Currencytext extends StatelessWidget {
  const Currencytext({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Image(width: 25, image: AssetImage('assets/images/visa.png')),
                Text(
                  ' *****8299',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Payment Method',
              style: TextStyle(
                  fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey),
              textAlign: TextAlign.start,
            ),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$249.6',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.end,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Price',
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                textAlign: TextAlign.end,
              ),
            ],
          )
        ]);
  }
}
