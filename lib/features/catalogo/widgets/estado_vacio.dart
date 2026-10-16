import 'package:flutter/material.dart';

class EstadoVacio extends StatelessWidget {
  const EstadoVacio({
    super.key,
    required this.mensaje,
    this.icono = Icons.search_off,
  });

  final String mensaje;
  final IconData icono;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 42, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(mensaje, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
