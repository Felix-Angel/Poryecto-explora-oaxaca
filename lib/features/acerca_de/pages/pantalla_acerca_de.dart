import 'package:flutter/material.dart';

import '../widgets/elemento_informacion.dart';

class PantallaAcercaDe extends StatelessWidget {
  const PantallaAcercaDe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de Explora Oaxaca'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 12),
            const Icon(Icons.explore, size: 80),
            const SizedBox(height: 16),
            Text(
              'EXPLORA OAXACA',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Una aplicación para descubrir destinos turísticos de Oaxaca.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ElementoInformacion(
              titulo: 'Objetivo',
              descripcion:
                  'Facilitar la exploración de destinos turísticos de '
                  'Oaxaca mediante información organizada y accesible.',
              icono: Icons.flag_outlined,
            ),
            ElementoInformacion(
              titulo: '¿Qué puedes encontrar?',
              descripcion:
                  'Un catálogo de destinos, sus municipios, categorías '
                  'y la información disponible de cada lugar.',
              icono: Icons.place_outlined,
            ),
            ElementoInformacion(
              titulo: 'Exploración por categorías',
              descripcion:
                  'Consultar los destinos agrupados según la categoría '
                  'registrada en el catálogo.',
              icono: Icons.category_outlined,
            ),
            ElementoInformacion(
              titulo: 'Información del proyecto',
              descripcion:
                  'La información que se muestra depende de los datos '
                  'registrados en el catálogo de la aplicación.',
              icono: Icons.info_outline,
            ),
          ],
        ),
      ),
    );
  }
}
