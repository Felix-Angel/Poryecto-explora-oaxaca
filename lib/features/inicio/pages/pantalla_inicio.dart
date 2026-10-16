import 'package:flutter/material.dart';

import '../../../data/destinos_repository.dart';
import '../../catalogo/pages/pantalla_catalogo.dart';
import '../../categorias/pages/pantalla_categorias.dart';
import '../../acerca_de/pages/pantalla_acerca_de.dart';
import '../widgets/tarjeta_bienvenida.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  void _abrirPantalla(BuildContext context, Widget pantalla) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => pantalla));
  }

  @override
  Widget build(BuildContext context) {
    final estilos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Explora Oaxaca'), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 12),
            const Icon(Icons.explore, size: 76),
            const SizedBox(height: 12),
            Text(
              '¡Descubre Oaxaca!',
              textAlign: TextAlign.center,
              style: estilos.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Explora sus destinos, conoce sus categorías '
              'y descubre la información disponible de cada lugar.',
              textAlign: TextAlign.center,
              style: estilos.bodyLarge,
            ),
            const SizedBox(height: 24),
            const TarjetaBienvenida(
              titulo: 'Descubre nuevos lugares',
              descripcion:
                  'Conoce los destinos turísticos registrados '
                  'en nuestro catálogo.',
              icono: Icons.landscape,
            ),
            const SizedBox(height: 12),
            const TarjetaBienvenida(
              titulo: 'Explora por categorías',
              descripcion: 'Encuentra los destinos agrupados por su categoría.',
              icono: Icons.category_outlined,
            ),
            const SizedBox(height: 12),
            const TarjetaBienvenida(
              titulo: 'Conoce el proyecto',
              descripcion:
                  'Consulta el objetivo y la información de la aplicación.',
              icono: Icons.info_outline,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                _abrirPantalla(
                  context,
                  PantallaCatalogo(repository: const DestinosRepository()),
                );
              },
              icon: const Icon(Icons.place_outlined),
              label: const Text('Ver catálogo de destinos'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                _abrirPantalla(context, const PantallaCategorias());
              },
              icon: const Icon(Icons.category_outlined),
              label: const Text('Explorar categorías'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                _abrirPantalla(context, const PantallaAcercaDe());
              },
              icon: const Icon(Icons.info_outline),
              label: const Text('Acerca del proyecto'),
            ),
          ],
        ),
      ),
    );
  }
}
