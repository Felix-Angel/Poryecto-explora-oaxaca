import 'package:flutter/material.dart';

import '../../../shared/widgets/widget_imagen_destino.dart';

class TarjetaCategoria extends StatelessWidget {
  const TarjetaCategoria({
    super.key,
    required this.nombre,
    required this.cantidadDestinos,
    required this.icono,
    required this.imagen,
    required this.onTap,
  });

  final String nombre;
  final int cantidadDestinos;
  final IconData icono;
  final String imagen;
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
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: 78,
                  height: 78,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      WidgetImagenDestino(
                        ruta: imagen,
                        ancho: 78,
                        altura: 78,
                        proporcion: null,
                        radioBorde: 15,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: colores.tertiaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icono,
                            color: colores.onTertiaryContainer,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$cantidadDestinos '
                      '${cantidadDestinos == 1 ? 'destino' : 'destinos'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colores.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
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
