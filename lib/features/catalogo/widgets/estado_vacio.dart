import 'package:flutter/material.dart';

class EstadoVacio extends StatelessWidget {
  const EstadoVacio({
    super.key,
    required this.mensaje,
    this.icono = Icons.search_off,
    this.titulo,
  });

  final String mensaje;
  final IconData icono;
  final String? titulo;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 42, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          if (titulo != null) ...[
            Text(
              titulo!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
          ],
          Text(mensaje, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
