import 'package:flutter/material.dart';

class WidgetImagenDestino extends StatelessWidget {
  const WidgetImagenDestino({
    super.key,
    required this.ruta,
    this.altura,
    this.ancho,
    this.proporcion = 16 / 9,
    this.radioBorde = 16,
    this.ajuste = BoxFit.cover,
  });

  final String ruta;
  final double? altura;
  final double? ancho;
  final double? proporcion;
  final double radioBorde;
  final BoxFit ajuste;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(ruta);
    final esRemota = uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https');
    Widget errorBuilder(
      BuildContext context,
      Object error,
      StackTrace? stackTrace,
    ) => ColoredBox(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Center(
          child: Icon(Icons.image_not_supported_outlined, size: 44),
        ),
      );
    final imagen = esRemota
        ? Image.network(
            ruta,
            width: ancho,
            height: altura,
            fit: ajuste,
            errorBuilder: errorBuilder,
          )
        : Image.asset(
            ruta,
            width: ancho,
            height: altura,
            fit: ajuste,
            errorBuilder: errorBuilder,
          );

    final SizedBox contenido;
    if (altura != null || proporcion == null) {
      contenido = SizedBox(width: ancho, height: altura, child: imagen);
    } else {
      contenido = SizedBox(
        width: ancho,
        child: AspectRatio(aspectRatio: proporcion!, child: imagen),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radioBorde),
      child: contenido,
    );
  }
}
