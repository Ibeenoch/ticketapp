import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Processingscreen extends StatelessWidget {
  const Processingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processing'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/payment-details');
          },
          child: const Text('Payment Details'),
        ),
      ),
    );
  }
}
