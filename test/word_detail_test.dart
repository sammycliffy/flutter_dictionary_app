import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_word_search/screens/word_detail.dart';

void main() {
  testWidgets('WordDetail Widget Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: WordDetail(word: 'TestWord'),
      ),
    );

    // Verify that the widgets are displayed correctly
    expect(find.text('TestWord'), findsOneWidget);
    expect(find.text('[test-phonetic]'), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_outlined), findsOneWidget);

    // Tap the play button
    await tester.tap(find.byIcon(Icons.play_arrow_outlined));
    await tester.pumpAndSettle();

    // Verify that the audio is playing (you may need to adjust this part based on your actual audio logic)
    expect(find.byIcon(Icons.pause), findsOneWidget);

    // Tap the pause button
    await tester.tap(find.byIcon(Icons.pause));
    await tester.pumpAndSettle();

    // Verify that the audio is paused
    expect(find.byIcon(Icons.play_arrow_outlined), findsOneWidget);
  });
}
