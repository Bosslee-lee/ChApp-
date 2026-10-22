import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/welcome/welcome_screen.dart';

void main() {
  runApp(const ChApp());
}

class ChApp extends StatelessWidget {
  const ChApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const WelcomeScreen(),
    );
  }
}