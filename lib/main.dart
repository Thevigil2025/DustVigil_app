import 'package:flutter/material.dart';
import 'package:dustvigil/pages/login_page.dart';

void main() {
  runApp(const DustVigilApp());
}

class DustVigilApp extends StatelessWidget {
  const DustVigilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DustVigil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Color(0xFF6A1B9A), width: 2.0),
          ),
        ),
      ),
      home: const LoginPage(), // 👈 Starts here, then goes to MainNavigationPage after login
    );
  }
}
