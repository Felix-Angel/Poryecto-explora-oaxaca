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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        if (icono != null) ...[
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icono,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
              size: 25,
            ),
          ),
          const SizedBox(width: 14),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: estilos.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
              if (subtitulo != null && subtitulo!.trim().isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  subtitulo!,
                  style: estilos.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
        ],
      ),
    );
  }
}
