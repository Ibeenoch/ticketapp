import 'package:flutter/material.dart';

class Currencytext extends StatelessWidget {
  String payment;
  String price;
  Currencytext({super.key, required this.payment, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const Image(width: 25, image: AssetImage('assets/images/visa.png')),
            Text(
              ' *****$payment',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        const SizedBox(
          height: 3,
        ),
        const Text(
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
            '\$$price',
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.end,
          ),
          const SizedBox(
            height: 3,
          ),
          const Text(
            'Price',
            style: TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.grey),
            textAlign: TextAlign.end,
          ),
        ],
      )
    ]);
  }
}
