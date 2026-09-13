import 'package:flutter/material.dart';
import 'screens/setup_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ScorePertandinganApp());
}

class ScorePertandinganApp extends StatelessWidget {
  const ScorePertandinganApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papan Skor Pertandingan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkArena,
      home: const SetupScreen(),
    );
  }
}
