import 'package:flutter/material.dart';

import '../../../data/destinos_repository.dart';
import '../../../models/destino.dart';
import '../../../shared/widgets/widget_encabezado_seccion.dart';
import '../../favoritos/favoritos_store.dart';
import '../../favoritos/pages/pantalla_favoritos.dart';
import 'pantalla_detalle_destino.dart';
import '../widgets/campo_busqueda.dart';
import '../widgets/estado_carga.dart';
import '../widgets/estado_vacio.dart';
import '../widgets/tarjeta_destino.dart';

class PantallaCatalogo extends StatefulWidget {
  const PantallaCatalogo({
    super.key,
    this.repository = const DestinosRepository(),
  });

  final DestinosRepository repository;

  @override
  State<PantallaCatalogo> createState() => _PantallaCatalogoState();
}

class _PantallaCatalogoState extends State<PantallaCatalogo> {
  late Future<List<Destino>> _destinos;
  String _busqueda = '';

  @override
  void initState() {
    super.initState();
    _destinos = widget.repository.cargarDestinos();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Explora el catálogo de Oaxaca'),
      actions: [
        IconButton(
          tooltip: 'Ver favoritos',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const PantallaFavoritos()),
          ),
          icon: const Icon(Icons.favorite_border),
        ),
      ],
    ),
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: const WidgetEncabezadoSeccion(
              titulo: 'Destinos para descubrir',
              subtitulo: 'Explora lugares naturales, históricos y culturales.',
              icono: Icons.explore_outlined,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: CampoBusqueda(
              texto: _busqueda,
              onChanged: (texto) => setState(() => _busqueda = texto),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Set<String>>(
              valueListenable: FavoritosStore.instancia.ids,
              builder: (context, favoritos, _) => FutureBuilder<List<Destino>>(
                future: _destinos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const EstadoCarga();
                  }
                  if (snapshot.hasError) {
                    return EstadoVacio(
                      icono: Icons.error_outline,
                      mensaje: snapshot.error is DestinosCargaException
                          ? (snapshot.error! as DestinosCargaException).mensaje
                          : 'No se pudieron cargar los destinos. Intenta nuevamente.',
                    );
                  }
                  final consulta = _busqueda.trim().toLowerCase();
                  final destinos = snapshot.data!
                      .where(
                        (destino) =>
                            destino.nombre.toLowerCase().contains(consulta),
                      )
                      .toList();
                  if (destinos.isEmpty) {
                    return const EstadoVacio(
                      mensaje: 'No encontramos destinos con esa búsqueda.',
                    );
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              size: 18,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${destinos.length} '
                              '${destinos.length == 1 ? 'lugar para descubrir' : 'lugares para descubrir'}',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: destinos.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final destino = destinos[index];
                            return TarjetaDestino(
                              destino: destino,
                              esFavorito: favoritos.contains(destino.id),
                              onAlternarFavorito: () =>
                                  FavoritosStore.instancia.alternar(destino.id),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      PantallaDetalleDestino(destino: destino),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
