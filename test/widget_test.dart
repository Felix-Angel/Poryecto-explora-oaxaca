import 'package:flutter_test/flutter_test.dart';
import 'package:explora_oaxaca/app.dart';

void main() {
  testWidgets('La aplicación Explora Oaxaca inicia correctamente', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ExploraOaxacaApp());

    expect(find.text('Explora Oaxaca'), findsOneWidget);
  });
}
