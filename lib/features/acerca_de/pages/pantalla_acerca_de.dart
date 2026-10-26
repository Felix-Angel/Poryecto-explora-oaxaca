import 'package:flutter/material.dart';

import '../../../shared/widgets/widget_encabezado_seccion.dart';
import '../../../shared/widgets/widget_imagen_destino.dart';
import '../../favoritos/pages/pantalla_favoritos.dart';
import '../widgets/elemento_informacion.dart';

class PantallaAcercaDe extends StatelessWidget {
  const PantallaAcercaDe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de Explora Oaxaca'),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                height: 190,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const SizedBox.expand(
                      child: WidgetImagenDestino(
                        ruta:
                            'https://tzmedia.b-cdn.net/media/images/mx/place/max/afb48af5594be5bbbea7ec17c9746b3a.jpg?1582270511',
                        proporcion: null,
                        radioBorde: 0,
                      ),
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x11000000), Color(0xC9000000)],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      bottom: 16,
                      child: Row(
                        children: [
                          const Icon(Icons.explore,
                              color: Colors.white, size: 21),
                          const SizedBox(width: 8),
                          Text(
                            'Cultura que inspira',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
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
