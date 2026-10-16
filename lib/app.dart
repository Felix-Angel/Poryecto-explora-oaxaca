import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/catalogo/pages/pantalla_catalogo.dart';

class ExploraOaxacaApp extends StatelessWidget {
  const ExploraOaxacaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explora Oaxaca',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const PantallaCatalogo(),
    );
  }
}
