import 'package:flutter/material.dart';

class TarjetaCategoria extends StatelessWidget {
  const TarjetaCategoria({
    super.key,
    required this.nombre,
    required this.cantidadDestinos,
    required this.icono,
    required this.onTap,
  });

  final String nombre;
  final int cantidadDestinos;
  final IconData icono;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colores.primaryContainer,
                foregroundColor: colores.onPrimaryContainer,
                child: Icon(icono),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$cantidadDestinos '
                      '${cantidadDestinos == 1 ? 'destino' : 'destinos'}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
