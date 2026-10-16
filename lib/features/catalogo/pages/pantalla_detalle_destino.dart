import 'package:flutter/material.dart';

import '../../../models/destino.dart';
import '../widgets/etiqueta_categoria.dart';

class PantallaDetalleDestino extends StatelessWidget {
  const PantallaDetalleDestino({super.key, required this.destino});

  final Destino destino;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(destino.nombre),
      leading: IconButton(
        tooltip: 'Regresar al catálogo',
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
    ),
    body: ListView(
      children: [
        Image.asset(
          destino.imagen,
          height: 260,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => SizedBox(
            height: 220,
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
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
                label: const Text('Volver al catálogo'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
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
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icono, size: 20),
            const SizedBox(width: 8),
            Text(
              titulo,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(contenido, style: Theme.of(context).textTheme.bodyLarge),
      ],
    ),
  );
}

class _DetalleLista extends StatelessWidget {
  const _DetalleLista({required this.titulo, required this.elementos});

  final String titulo;
  final List<String> elementos;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        ...elementos.map(
          (elemento) => Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('•  '),
                Expanded(child: Text(elemento)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
