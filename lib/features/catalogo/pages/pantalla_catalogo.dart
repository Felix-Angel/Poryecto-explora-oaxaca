import 'package:flutter/material.dart';

import '../widgets/tarjeta_destino.dart';

class PantallaCatalogo extends StatelessWidget {
  const PantallaCatalogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Destinos de Oaxaca')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          TarjetaDestino(
            nombre: 'Hierve el Agua',
            municipio: 'San Lorenzo Albarradas, Oaxaca',
            descripcion:
                'Formaciones naturales de agua mineral y '
                'vistas panorámicas de las montañas.',
            imagenUrl: 'assets/images/hierve_el_agua.jpg',
          ),
          SizedBox(height: 16),
          TarjetaDestino(
            nombre: 'Monte Albán',
            municipio: 'Oaxaca de Juárez, Oaxaca',
            descripcion:
                'Zona arqueológica zapoteca con plazas, '
                'pirámides y una gran riqueza histórica.',
            imagenUrl: 'assets/images/monte_alban.jpg',
          ),
          SizedBox(height: 16),
          TarjetaDestino(
            nombre: 'Santo Domingo de Guzmán',
            municipio: 'Oaxaca de Juárez, Oaxaca',
            descripcion:
                'Templo histórico destacado por su '
                'arquitectura y ornamentación.',
            imagenUrl: 'assets/images/santo_domingo.jpg',
          ),
        ],
      ),
    );
  }
}
