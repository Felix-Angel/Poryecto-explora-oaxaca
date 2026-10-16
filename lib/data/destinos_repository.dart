import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/destino.dart';

class DestinosRepository {
  const DestinosRepository();

  static const assetPath = 'assets/data/destinos.json';

  Future<List<Destino>> cargarDestinos({AssetBundle? bundle}) async {
    try {
      final jsonString = await (bundle ?? rootBundle).loadString(assetPath);
      final decoded = jsonDecode(jsonString);
      if (decoded is! List) {
        throw const FormatException('La raíz del catálogo debe ser una lista.');
      }
      return List<Destino>.unmodifiable(
        decoded.map((registro) {
          if (registro is! Map<String, dynamic>) {
            throw const FormatException(
              'Cada destino debe ser un objeto JSON.',
            );
          }
          return Destino.fromJson(registro);
        }),
      );
    } on FormatException catch (error) {
      throw DestinosCargaException(
        'El catálogo tiene un formato inválido.',
        error,
      );
    } on FlutterError catch (error) {
      throw DestinosCargaException(
        'No se pudo leer el archivo del catálogo.',
        error,
      );
    }
  }
}

class DestinosCargaException implements Exception {
  const DestinosCargaException(this.mensaje, [this.causa]);

  final String mensaje;
  final Object? causa;

  @override
  String toString() => mensaje;
}
