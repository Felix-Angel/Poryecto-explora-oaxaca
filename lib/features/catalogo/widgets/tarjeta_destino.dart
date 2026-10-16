import 'package:flutter/material.dart';

import '../../../models/destino.dart';
import 'etiqueta_categoria.dart';

class TarjetaDestino extends StatelessWidget {
  const TarjetaDestino({super.key, required this.destino, required this.onTap});

  final Destino destino;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.zero,
    elevation: 2,
    child: InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            destino.imagen,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 180,
              width: double.infinity,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported_outlined, size: 45),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destino.nombre,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text('${destino.municipio}, ${destino.ubicacion}'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                EtiquetaCategoria(categoria: destino.categoria),
                Text(
                  destino.descripcion,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
