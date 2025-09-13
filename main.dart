import 'package:flutter/material.dart';

import 'screens/borrow_book_screen.dart';
import 'screens/dashboard_screen.dart'; // ⬅️ Tambahkan ini
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/pickup_book_screen.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(const LokerBukuApp());
}

class LokerBukuApp extends StatelessWidget {
  const LokerBukuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loker Buku',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF464577),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/borrow': (context) => const BorrowBookScreen(),
        '/pickup': (context) => const PickupBookScreen(),
      },
    );
  }
}
