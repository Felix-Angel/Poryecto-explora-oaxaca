import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

class ExploraOaxacaApp extends StatelessWidget {
  const ExploraOaxacaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explora Oaxaca',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'Explora Oaxaca',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
