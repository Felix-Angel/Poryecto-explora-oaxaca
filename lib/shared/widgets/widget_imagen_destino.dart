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

  String? _rutaRespaldoLocal(Uri? uri) {
    if (uri == null) return null;

    if (uri.path.endsWith('/hierve-el-agua-FEAURED.jpg')) {
      return 'assets/images/hierve_el_agua.jpg';
    }
    if (uri.path.endsWith('/R.b62b88900421075d3fe6feb517f09bb5')) {
      return 'assets/images/monte_alban.jpg';
    }
    if (uri.path.endsWith('/afb48af5594be5bbbea7ec17c9746b3a.jpg')) {
      return 'assets/images/santo_domingo.jpg';
    }
    return null;
  }

  Widget _marcadorImagenNoDisponible(BuildContext context) => ColoredBox(
    color: Theme.of(context).colorScheme.surfaceContainerHighest,
    child: const Center(
      child: Icon(Icons.image_not_supported_outlined, size: 44),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(ruta);
    final esRemota = uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https');
    final assetRespaldo = esRemota ? _rutaRespaldoLocal(uri) : null;

    Widget errorBuilder(
      BuildContext context,
      Object error,
      StackTrace? stackTrace,
    ) {
      if (assetRespaldo != null) {
        return Image.asset(
          assetRespaldo,
          width: ancho,
          height: altura,
          fit: ajuste,
          errorBuilder: (context, error, stackTrace) =>
              _marcadorImagenNoDisponible(context),
        );
      }
      return _marcadorImagenNoDisponible(context);
    }
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
