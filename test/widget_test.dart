import 'package:explora_oaxaca/app.dart';
import 'package:explora_oaxaca/data/destinos_repository.dart';
import 'package:explora_oaxaca/features/catalogo/pages/pantalla_catalogo.dart';
import 'package:explora_oaxaca/models/destino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('la aplicación inicia en la pantalla de inicio', (tester) async {
    await tester.pumpWidget(
      ExploraOaxacaApp(destinosRepository: _FakeDestinosRepository()),
    );

    expect(find.text('Explora Oaxaca'), findsOneWidget);
  });

  test('el JSON carga y se convierte en tres destinos', () async {
    const repository = DestinosRepository();
    final destinos = await repository.cargarDestinos();

    expect(destinos, hasLength(3));
    expect(destinos.map((destino) => destino.nombre), contains('Monte Albán'));
    expect(destinos.first.imagen, 'assets/images/hierve_el_agua.jpg');
  });

  test('el modelo rechaza listas con elementos de tipo incorrecto', () {
    expect(
      () => Destino.fromJson({
        'id': 'prueba',
        'nombre': 'Prueba',
        'municipio': '',
        'ubicacion': '',
        'categoria': '',
        'descripcion': '',
        'historia': '',
        'actividades': [1],
        'recomendaciones': [],
        'imagen': '',
      }),
      throwsFormatException,
    );
  });

  testWidgets('permite buscar un destino y abrir y cerrar su detalle', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PantallaCatalogo(repository: _FakeDestinosRepository()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Explora el catálogo de Oaxaca'), findsOneWidget);
    expect(find.text('Hierve el Agua'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Monte');
    await tester.pumpAndSettle();
    expect(find.text('Monte Albán'), findsOneWidget);
    expect(find.text('Hierve el Agua'), findsNothing);

    await tester.tap(find.text('Monte Albán'));
    await tester.pumpAndSettle();
    expect(find.text('Descripción'), findsOneWidget);
    expect(find.text('Zona arqueológica'), findsOneWidget);

    await tester.tap(find.byTooltip('Regresar'));
    await tester.pumpAndSettle();
    expect(find.text('Explora el catálogo de Oaxaca'), findsOneWidget);
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
