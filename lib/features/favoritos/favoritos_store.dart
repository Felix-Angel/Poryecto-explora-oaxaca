import 'package:flutter/foundation.dart';

class FavoritosStore {
  FavoritosStore._();

  static final FavoritosStore instancia = FavoritosStore._();

  final ValueNotifier<Set<String>> _ids = ValueNotifier<Set<String>>(
    <String>{},
  );

  ValueListenable<Set<String>> get ids => _ids;

  bool contiene(String destinoId) => _ids.value.contains(destinoId);

  void alternar(String destinoId) {
    final actualizados = Set<String>.of(_ids.value);
    if (!actualizados.add(destinoId)) {
      actualizados.remove(destinoId);
    }
    _ids.value = Set<String>.unmodifiable(actualizados);
  }

  void limpiar() => _ids.value = <String>{};
}
