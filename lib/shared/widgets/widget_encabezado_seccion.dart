import 'package:flutter/material.dart';

class WidgetEncabezadoSeccion extends StatelessWidget {
  const WidgetEncabezadoSeccion({
    super.key,
    required this.titulo,
    this.subtitulo,
    this.icono,
  });

  final String titulo;
  final String? subtitulo;
  final IconData? icono;

  @override
  Widget build(BuildContext context) {
    final estilos = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icono != null) ...[
          Icon(icono, color: Theme.of(context).colorScheme.primary, size: 28),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: estilos.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitulo != null && subtitulo!.trim().isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(subtitulo!, style: estilos.bodyMedium),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
