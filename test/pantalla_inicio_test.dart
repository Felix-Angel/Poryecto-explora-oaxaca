import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:explora_oaxaca/features/inicio/pages/pantalla_inicio.dart';

void main() {
  testWidgets('la pantalla de inicio muestra sus accesos', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaInicio()));

    expect(find.text('¡Descubre Oaxaca!'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Ver catálogo de destinos'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Ver catálogo de destinos'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Explorar categorías'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Explorar categorías'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Acerca del proyecto'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Acerca del proyecto'), findsOneWidget);
  });

  testWidgets('el botón de categorías abre la pantalla correspondiente', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaInicio()));

    await tester.scrollUntilVisible(
      find.text('Explorar categorías'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    await tester.tap(find.text('Explorar categorías'));
    await tester.pumpAndSettle();

    expect(find.text('Categorías'), findsOneWidget);
  });
}
