import 'package:explora_oaxaca/features/catalogo/pages/pantalla_detalle_destino.dart';
import 'package:explora_oaxaca/data/destinos_repository.dart';
import 'package:explora_oaxaca/features/favoritos/favoritos_store.dart';
import 'package:explora_oaxaca/features/favoritos/pages/pantalla_favoritos.dart';
import 'package:explora_oaxaca/models/destino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('el detalle evita desbordamientos en una pantalla estrecha', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: PantallaDetalleDestino(
          destino: Destino(
            id: 'santo-domingo',
            nombre: 'Santo Domingo de Guzmán',
            municipio: 'Oaxaca de Juárez',
            ubicacion: 'Oaxaca',
            categoria: 'Templo histórico',
            descripcion: 'Templo histórico destacado por su arquitectura.',
            historia: '',
            actividades: [],
            recomendaciones: [],
            imagen: 'assets/images/santo_domingo.jpg',
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Santo Domingo de Guzmán'), findsNWidgets(2));
  });

  testWidgets(
    'el estado vacío de favoritos se adapta a una pantalla estrecha',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 640));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      FavoritosStore.instancia.limpiar();
      await tester.pumpWidget(
        MaterialApp(
          home: PantallaFavoritos(
            repository: _EmptyDestinosRepository(),
            favoritos: FavoritosStore.instancia,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Aún no tienes favoritos'), findsOneWidget);
    },
  );
}

class _EmptyDestinosRepository extends DestinosRepository {
  @override
  Future<List<Destino>> cargarDestinos({AssetBundle? bundle}) async => [];
}
