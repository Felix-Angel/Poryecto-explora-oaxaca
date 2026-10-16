import 'package:flutter/material.dart';

import '../../../data/destinos_repository.dart';
import '../../../models/destino.dart';
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
      title: const Text('Destinos de Oaxaca'),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
    ),
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: CampoBusqueda(
              texto: _busqueda,
              onChanged: (texto) => setState(() => _busqueda = texto),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Destino>>(
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
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: destinos.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final destino = destinos[index];
                    return TarjetaDestino(
                      destino: destino,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              PantallaDetalleDestino(destino: destino),
                        ),
                      ),
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
