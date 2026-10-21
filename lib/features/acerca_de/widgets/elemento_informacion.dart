import 'package:flutter/material.dart';

class ElementoInformacion extends StatelessWidget {
  const ElementoInformacion({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.icono,
  });

  final String titulo;
  final String descripcion;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final estilos = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: colores.tertiaryContainer,
              foregroundColor: colores.onTertiaryContainer,
              child: Icon(icono),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: estilos.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    descripcion,
                    style: estilos.bodyMedium?.copyWith(
                      height: 1.45,
                      color: colores.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
