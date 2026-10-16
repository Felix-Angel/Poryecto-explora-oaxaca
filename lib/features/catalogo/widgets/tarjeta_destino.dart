import 'package:flutter/material.dart';

import '../../../models/destino.dart';
import '../../../shared/widgets/widget_imagen_destino.dart';
import 'etiqueta_categoria.dart';

class TarjetaDestino extends StatelessWidget {
  const TarjetaDestino({
    super.key,
    required this.destino,
    required this.onTap,
    this.esFavorito = false,
    this.onAlternarFavorito,
  });

  final Destino destino;
  final VoidCallback onTap;
  final bool esFavorito;
  final VoidCallback? onAlternarFavorito;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.zero,
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetImagenDestino(
            ruta: destino.imagen,
            altura: 180,
            ancho: double.infinity,
            proporcion: null,
            radioBorde: 0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 14, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        destino.nombre,
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (onAlternarFavorito != null)
                      IconButton(
                        tooltip: esFavorito
                            ? 'Quitar de favoritos'
                            : 'Agregar a favoritos',
                        onPressed: onAlternarFavorito,
                        icon: Icon(
                          esFavorito ? Icons.favorite : Icons.favorite_border,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text('${destino.municipio}, ${destino.ubicacion}'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                EtiquetaCategoria(categoria: destino.categoria),
                const SizedBox(height: 10),
                Text(
                  destino.descripcion,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.45,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
