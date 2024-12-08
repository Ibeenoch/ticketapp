import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:powerapp/screens/PinScreen.dart';
import 'package:powerapp/screens/ProcessingScreen.dart';
import 'package:powerapp/screens/ScanScreen.dart';
import 'package:powerapp/BottomBar.dart';
import 'package:powerapp/screens/paymentScreen.dart';
import 'package:powerapp/screens/payment_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BottomBar(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const Paymentscreen(),
      ),
      GoRoute(
        path: '/scan',
        builder: (context, state) => const Scanscreen(),
      ),
      GoRoute(
        path: '/pin',
        builder: (context, state) => const Pinscreen(),
      ),
      GoRoute(
        path: '/processing',
        builder: (context, state) => const Processingscreen(),
      ),
      GoRoute(
        path: '/payment-details',
        builder: (context, state) => const PaymentDetails(),
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
