import 'package:flutter/material.dart';

import '../../../models/destino.dart';
import '../../../shared/widgets/widget_imagen_destino.dart';
import '../../favoritos/favoritos_store.dart';
import '../../favoritos/pages/pantalla_favoritos.dart';
import '../widgets/etiqueta_categoria.dart';

class PantallaDetalleDestino extends StatelessWidget {
  const PantallaDetalleDestino({
    super.key,
    required this.destino,
    this.favoritos,
  });

  final Destino destino;
  final FavoritosStore? favoritos;

  @override
  Widget build(BuildContext context) {
    final store = favoritos ?? FavoritosStore.instancia;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          destino.nombre,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          tooltip: 'Regresar',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          ValueListenableBuilder<Set<String>>(
            valueListenable: store.ids,
            builder: (context, ids, _) {
              final esFavorito = ids.contains(destino.id);
              return IconButton(
                tooltip: esFavorito
                    ? 'Quitar de favoritos'
                    : 'Agregar a favoritos',
                onPressed: () => store.alternar(destino.id),
                icon: Icon(esFavorito ? Icons.favorite : Icons.favorite_border),
              );
            },
          ),
          IconButton(
            tooltip: 'Ver favoritos',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => PantallaFavoritos(favoritos: store),
              ),
            ),
            icon: const Icon(Icons.bookmark_border),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Stack(
            children: [
              WidgetImagenDestino(
                ruta: destino.imagen,
                altura: 290,
                ancho: double.infinity,
                proporcion: null,
                radioBorde: 24,
              ),
              Positioned(
                left: 14,
                bottom: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xCC26352D),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: Colors.white, size: 16),
                      const SizedBox(width: 5),
                      Text(
                        destino.municipio,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 20, 4, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destino.nombre,
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                EtiquetaCategoria(categoria: destino.categoria),
                _DetalleSeccion(
                  titulo: 'Ubicación',
                  contenido: '${destino.municipio}, ${destino.ubicacion}',
                  icono: Icons.location_on_outlined,
                ),
                _DetalleSeccion(
                  titulo: 'Descripción',
                  contenido: destino.descripcion,
                  icono: Icons.info_outline,
                ),
                if (destino.historia.trim().isNotEmpty)
                  _DetalleSeccion(
                    titulo: 'Historia e importancia cultural',
                    contenido: destino.historia,
                    icono: Icons.account_balance_outlined,
                  ),
                if (destino.actividades.isNotEmpty)
                  _DetalleLista(
                    titulo: 'Actividades',
                    elementos: destino.actividades,
                  ),
                if (destino.recomendaciones.isNotEmpty)
                  _DetalleLista(
                    titulo: 'Recomendaciones para visitantes',
                    elementos: destino.recomendaciones,
                  ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Regresar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetalleSeccion extends StatelessWidget {
  const _DetalleSeccion({
    required this.titulo,
    required this.contenido,
    required this.icono,
  });

  final String titulo;
  final String contenido;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(top: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colores.primaryContainer,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icono, color: colores.primary, size: 21),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    contenido,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
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

class _DetalleLista extends StatelessWidget {
  const _DetalleLista({required this.titulo, required this.elementos});

  final String titulo;
  final List<String> elementos;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(top: 14),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              ...elementos.map(
                (elemento) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          elemento,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
