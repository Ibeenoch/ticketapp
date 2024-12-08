import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Paymentscreen extends StatelessWidget {
  const Paymentscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.payment)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.go('/scan');
            },
            child: const Text('Go to Scan')),
      ),
    );
  }
}
