import 'package:flutter/material.dart';

import '../../../shared/widgets/widget_encabezado_seccion.dart';
import '../../favoritos/pages/pantalla_favoritos.dart';
import '../widgets/elemento_informacion.dart';

class PantallaAcercaDe extends StatelessWidget {
  const PantallaAcercaDe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de Explora Oaxaca'),
        centerTitle: true,
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
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 12),
            const WidgetEncabezadoSeccion(
              titulo: 'Explora Oaxaca',
              subtitulo: 'Una aplicación para descubrir destinos turísticos de Oaxaca.',
              icono: Icons.explore_outlined,
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
