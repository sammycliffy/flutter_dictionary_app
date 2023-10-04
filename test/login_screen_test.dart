import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_word_search/screens/login.dart';

void main() {
  testWidgets('LoginScreen Widget Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Find widgets by keys or text
    final emailField = find.byType(TextFormField).at(0);
    final passwordField = find.byType(TextFormField).at(1);
    final loginButton = find.text('Login');

    // Verify that the widgets are displayed correctly
    expect(find.text('Login'), findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    // Enter test values in email and password fields
    await tester.enterText(emailField, 'test@test.com');
    await tester.enterText(passwordField, 'password');

    // Tap the login button
    await tester.tap(loginButton);

    // Wait for the UI to update
    await tester.pumpAndSettle();

    // Verify that the loading indicator is displayed
    final loadingIndicator = find.byType(CircularProgressIndicator);
    expect(loadingIndicator, findsOneWidget);

    // Verify that the loading indicator disappears after a while
    await tester
        .pump(const Duration(seconds: 2)); // Adjust the duration as needed
    expect(loadingIndicator, findsNothing);

    // You can add more test cases based on your app's behavior
  });
}
