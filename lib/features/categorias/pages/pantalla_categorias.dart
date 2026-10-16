import 'package:flutter/material.dart';

import '../../../data/destinos_repository.dart';
import '../../../models/destino.dart';
import '../../catalogo/pages/pantalla_detalle_destino.dart';
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
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Destino>>(
          future: _destinos,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              final error = snapshot.error;
              final mensaje = error is DestinosCargaException
                  ? error.mensaje
                  : 'No se pudieron cargar las categorías.';

              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(mensaje, textAlign: TextAlign.center),
                ),
              );
            }

            final destinos = snapshot.data ?? <Destino>[];

            if (destinos.isEmpty) {
              return const Center(
                child: Text('Todavía no hay destinos disponibles.'),
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
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      showDragHandle: true,
                      builder: (context) {
                        return SafeArea(
                          child: ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(16),
                            children: [
                              Text(
                                nombre,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 12),
                              ...destinosCategoria.map(
                                (destino) => ListTile(
                                  leading: const Icon(Icons.place_outlined),
                                  title: Text(destino.nombre),
                                  subtitle: Text(destino.municipio),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () {
                                    Navigator.of(context).pop();

                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (_) => PantallaDetalleDestino(
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
    );
  }
}
