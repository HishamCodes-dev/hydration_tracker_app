import 'package:flutter/material.dart';
import 'ui/app_theme.dart';
import 'screens/input_screen.dart';

void main() {
  runApp(const HydrationTrackerApp());
}

class HydrationTrackerApp extends StatelessWidget {
  const HydrationTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hydration Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const InputScreen(),
    );
  }
}
