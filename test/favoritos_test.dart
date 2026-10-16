import 'package:explora_oaxaca/data/destinos_repository.dart';
import 'package:explora_oaxaca/features/catalogo/pages/pantalla_catalogo.dart';
import 'package:explora_oaxaca/features/favoritos/favoritos_store.dart';
import 'package:explora_oaxaca/features/favoritos/pages/pantalla_favoritos.dart';
import 'package:explora_oaxaca/models/destino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final store = FavoritosStore.instancia;

  setUp(() => store.limpiar());

  testWidgets('favoritos inicia con un estado vacío', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PantallaFavoritos(
          repository: _FakeDestinosRepository(),
          favoritos: store,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Aún no tienes favoritos'), findsOneWidget);
  });

  testWidgets('el detalle y favoritos comparten el alta y la baja', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PantallaCatalogo(repository: _FakeDestinosRepository()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Hierve el Agua'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Agregar a favoritos'));
    await tester.pump();
    expect(store.contiene('hierve-el-agua'), isTrue);

    await tester.tap(find.byTooltip('Ver favoritos'));
    await tester.pumpAndSettle();
    expect(find.text('Hierve el Agua'), findsOneWidget);

    await tester.tap(find.byTooltip('Quitar de favoritos'));
    await tester.pumpAndSettle();
    expect(find.text('Aún no tienes favoritos'), findsOneWidget);
    expect(store.contiene('hierve-el-agua'), isFalse);
  });
}

class _FakeDestinosRepository extends DestinosRepository {
  @override
  Future<List<Destino>> cargarDestinos({AssetBundle? bundle}) async => [
    const Destino(
      id: 'hierve-el-agua',
      nombre: 'Hierve el Agua',
      municipio: 'San Lorenzo Albarradas',
      ubicacion: 'Oaxaca',
      categoria: 'Formación natural',
      descripcion: 'Formaciones naturales de agua mineral.',
      historia: '',
      actividades: [],
      recomendaciones: [],
      imagen: 'assets/images/hierve_el_agua.jpg',
    ),
    const Destino(
      id: 'monte-alban',
      nombre: 'Monte Albán',
      municipio: 'Oaxaca de Juárez',
      ubicacion: 'Oaxaca',
      categoria: 'Zona arqueológica',
      descripcion: 'Zona arqueológica zapoteca.',
      historia: '',
      actividades: [],
      recomendaciones: [],
      imagen: 'assets/images/monte_alban.jpg',
    ),
  ];
}
