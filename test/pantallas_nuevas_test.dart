import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:explora_oaxaca/features/acerca_de/pages/pantalla_acerca_de.dart';
import 'package:explora_oaxaca/features/categorias/pages/pantalla_categorias.dart';
import 'package:explora_oaxaca/features/categorias/widgets/tarjeta_categoria.dart';

void main() {
  testWidgets('la pantalla de categorías muestra los destinos', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaCategorias()));

    await tester.pumpAndSettle();

    expect(find.byType(TarjetaCategoria), findsNWidgets(3));
  });

  testWidgets('la pantalla acerca de muestra información del proyecto', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaAcercaDe()));

    await tester.pumpAndSettle();

    expect(find.text('EXPLORA OAXACA'), findsOneWidget);
    expect(find.text('Objetivo'), findsOneWidget);
  });
}
