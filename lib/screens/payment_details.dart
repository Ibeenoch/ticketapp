import 'package:flutter/material.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.money)),
          IconButton(onPressed: () {}, icon: Icon(Icons.payment_sharp)),
        ],
      ),
      body: const Center(
        child: Text('Payment Deatils'),
      ),
    );
  }
}
