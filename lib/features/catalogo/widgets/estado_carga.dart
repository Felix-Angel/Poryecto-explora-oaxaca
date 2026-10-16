import 'package:flutter/material.dart';

class EstadoCarga extends StatelessWidget {
  const EstadoCarga({super.key, this.mensaje = 'Cargando destinos...'});

  final String mensaje;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 12),
        Text(mensaje),
      ],
    ),
  );
}
