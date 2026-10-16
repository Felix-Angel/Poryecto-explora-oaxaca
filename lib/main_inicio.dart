import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/inicio/pages/pantalla_inicio.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Explora Oaxaca',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const PantallaInicio(),
    ),
  );
}
