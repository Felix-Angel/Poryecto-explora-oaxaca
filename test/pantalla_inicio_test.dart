import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:explora_oaxaca/features/inicio/pages/pantalla_inicio.dart';

void main() {
  testWidgets('la pantalla de inicio muestra sus accesos', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaInicio()));

    expect(find.text('¡Descubre Oaxaca!'), findsOneWidget);

    final catalogo = find.text('Ver catálogo de destinos');
    await tester.ensureVisible(catalogo);
    await tester.pumpAndSettle();
    expect(catalogo, findsOneWidget);

    final categorias = find.text('Categorías');
    await tester.ensureVisible(categorias);
    await tester.pumpAndSettle();
    expect(categorias, findsOneWidget);

    final favoritos = find.text('Favoritos');
    await tester.ensureVisible(favoritos);
    await tester.pumpAndSettle();
    expect(favoritos, findsOneWidget);

    final acerca = find.text('Acerca del proyecto');
    await tester.ensureVisible(acerca);
    await tester.pumpAndSettle();
    expect(acerca, findsOneWidget);
  });

  testWidgets('el botón de categorías abre la pantalla correspondiente', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaInicio()));

    final accesoCategorias = find.text('Categorías');
    await tester.ensureVisible(accesoCategorias);
    await tester.pumpAndSettle();

    await tester.tap(accesoCategorias);
    await tester.pumpAndSettle();

    expect(find.text('Categorías'), findsOneWidget);
  });
}
