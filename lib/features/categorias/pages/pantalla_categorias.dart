import 'package:flutter/material.dart';

import '../../../data/destinos_repository.dart';
import '../../../models/destino.dart';
import '../../../shared/widgets/widget_encabezado_seccion.dart';
import '../../catalogo/pages/pantalla_detalle_destino.dart';
import '../../catalogo/widgets/estado_carga.dart';
import '../../catalogo/widgets/estado_vacio.dart';
import '../../favoritos/pages/pantalla_favoritos.dart';
import '../widgets/tarjeta_categoria.dart';

class PantallaCategorias extends StatefulWidget {
  const PantallaCategorias({
    super.key,
    this.repository = const DestinosRepository(),
  });

  final DestinosRepository repository;

  @override
  State<PantallaCategorias> createState() => _PantallaCategoriasState();
}

class _PantallaCategoriasState extends State<PantallaCategorias> {
  late Future<List<Destino>> _destinos;

  @override
  void initState() {
    super.initState();
    _destinos = widget.repository.cargarDestinos();
  }

  IconData _obtenerIcono(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'formación natural':
        return Icons.landscape;
      case 'zona arqueológica':
        return Icons.account_balance;
      case 'templo histórico':
        return Icons.temple_buddhist;
      default:
        return Icons.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        actions: [
          IconButton(
            tooltip: 'Ver favoritos',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const PantallaFavoritos(),
              ),
            ),
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: WidgetEncabezadoSeccion(
                titulo: 'Explora por categoría',
                subtitulo: 'Elige un tipo de lugar para ver sus destinos.',
                icono: Icons.category_outlined,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Destino>>(
                future: _destinos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const EstadoCarga(mensaje: 'Cargando categorías...');
                  }

                  if (snapshot.hasError) {
                    final error = snapshot.error;
                    final mensaje = error is DestinosCargaException
                        ? error.mensaje
                        : 'No se pudieron cargar las categorías.';

                    return EstadoVacio(
                      titulo: 'No se pudieron cargar',
                      mensaje: mensaje,
                      icono: Icons.error_outline,
                    );
                  }

                  final destinos = snapshot.data ?? <Destino>[];

                  if (destinos.isEmpty) {
                    return const EstadoVacio(
                      titulo: 'Sin destinos',
                      mensaje: 'Todavía no hay destinos disponibles.',
                      icono: Icons.place_outlined,
                    );
                  }

                  final categorias = <String, List<Destino>>{};

                  for (final destino in destinos) {
                    categorias
                        .putIfAbsent(destino.categoria, () => <Destino>[])
                        .add(destino);
                  }

                  final nombresCategorias = categorias.keys.toList()..sort();

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: nombresCategorias.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final nombre = nombresCategorias[index];
                      final destinosCategoria = categorias[nombre]!;

                      return TarjetaCategoria(
                        nombre: nombre,
                        cantidadDestinos: destinosCategoria.length,
                        icono: _obtenerIcono(nombre),
                        imagen: destinosCategoria.first.imagen,
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            showDragHandle: true,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surface,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(28),
                              ),
                            ),
                            builder: (context) {
                              return SafeArea(
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(16),
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 46,
                                          height: 46,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Icon(
                                            _obtenerIcono(nombre),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                        const SizedBox(width: 13),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                nombre,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                '${destinosCategoria.length} '
                                                '${destinosCategoria.length == 1 ? 'destino disponible' : 'destinos disponibles'}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    ...destinosCategoria.map(
                                      (destino) => ListTile(
                                        leading: const Icon(
                                          Icons.place_outlined,
                                        ),
                                        title: Text(destino.nombre),
                                        subtitle: Text(destino.municipio),
                                        trailing: const Icon(
                                          Icons.chevron_right,
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop();

                                          Navigator.of(context).push(
                                            MaterialPageRoute<void>(
                                              builder: (_) =>
                                                  PantallaDetalleDestino(
                                                    destino: destino,
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
