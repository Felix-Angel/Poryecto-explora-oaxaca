import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'data/destinos_repository.dart';
import 'features/inicio/pages/pantalla_inicio.dart';

class ExploraOaxacaApp extends StatelessWidget {
  const ExploraOaxacaApp({
    super.key,
    this.destinosRepository = const DestinosRepository(),
  });

  final DestinosRepository destinosRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explora Oaxaca',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: PantallaInicio(repository: destinosRepository),
    );
  }
}
