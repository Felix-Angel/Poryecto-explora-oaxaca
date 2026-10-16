import 'package:flutter/material.dart';

import '../../../data/destinos_repository.dart';
import '../../../models/destino.dart';
import '../../../shared/widgets/widget_encabezado_seccion.dart';
import '../../catalogo/pages/pantalla_detalle_destino.dart';
import '../../catalogo/widgets/estado_carga.dart';
import '../../catalogo/widgets/estado_vacio.dart';
import '../../catalogo/widgets/tarjeta_destino.dart';
import '../favoritos_store.dart';

class PantallaFavoritos extends StatefulWidget {
  const PantallaFavoritos({
    super.key,
    this.repository = const DestinosRepository(),
    this.favoritos,
  });

  final DestinosRepository repository;
  final FavoritosStore? favoritos;

  @override
  State<PantallaFavoritos> createState() => _PantallaFavoritosState();
}

class _PantallaFavoritosState extends State<PantallaFavoritos> {
  late final Future<List<Destino>> _destinos;
  FavoritosStore get _favoritos => widget.favoritos ?? FavoritosStore.instancia;

  @override
  void initState() {
    super.initState();
    _destinos = widget.repository.cargarDestinos();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Favoritos')),
    body: SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: WidgetEncabezadoSeccion(
              titulo: 'Tus lugares guardados',
              subtitulo: 'Aquí aparecen los destinos que marcaste.',
              icono: Icons.favorite_outline,
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Set<String>>(
              valueListenable: _favoritos.ids,
              builder: (context, idsFavoritos, _) =>
                  FutureBuilder<List<Destino>>(
                    future: _destinos,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const EstadoCarga(
                          mensaje: 'Cargando favoritos...',
                        );
                      }
                      if (snapshot.hasError) {
                        final error = snapshot.error;
                        return EstadoVacio(
                          titulo: 'No se pudieron cargar',
                          mensaje: error is DestinosCargaException
                              ? error.mensaje
                              : 'Intenta volver a abrir esta pantalla.',
                          icono: Icons.error_outline,
                        );
                      }

                      final destinos = snapshot.data ?? <Destino>[];
                      final favoritos = destinos
                          .where((destino) => idsFavoritos.contains(destino.id))
                          .toList(growable: false);
                      if (favoritos.isEmpty) {
                        return const EstadoVacio(
                          titulo: 'Aún no tienes favoritos',
                          mensaje: 'Marca el corazón de un destino para guardarlo aquí.',
                          icono: Icons.favorite_border,
                        );
                      }

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 8, 20, 2),
                            child: Row(
                              children: [
                                Icon(Icons.favorite,
                                    size: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                const SizedBox(width: 8),
                                Text(
                                  '${favoritos.length} '
                                  '${favoritos.length == 1 ? 'lugar guardado' : 'lugares guardados'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
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
                              itemCount: favoritos.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final destino = favoritos[index];
                                return TarjetaDestino(
                                  destino: destino,
                                  esFavorito: true,
                                  onAlternarFavorito: () =>
                                      _favoritos.alternar(destino.id),
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => PantallaDetalleDestino(
                                        destino: destino,
                                        favoritos: _favoritos,
                                      ),
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
