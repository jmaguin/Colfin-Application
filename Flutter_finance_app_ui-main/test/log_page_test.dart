// Test file for log page.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_finance_app/pages/log_page.dart';

void main() {
  testWidgets('Log Page unit test', (WidgetTester tester) async {
    // Get "Add Item" button and text fields
    final addButton = find.byKey(ValueKey("addItemButton"));
    final nameField = find.byKey(ValueKey("nameField"));
    final priceField = find.byKey(ValueKey("priceField"));
    await tester.pumpWidget(MaterialApp(home: const LogPage()));

    // Verify that name, price, and category text fields exist
    expect(find.text('Enter Name'), findsOneWidget);
    expect(find.text('Enter Price'), findsOneWidget);
    expect(find.text('Food'), findsOneWidget);

    // Enter text in text fields
    await tester.enterText(nameField, "Hamburger");
    await tester.enterText(priceField, "8.99");

    // Verify Add Item button exists
    expect(find.text('Add Item'), findsOneWidget);

    // Tap Add Item button
    await tester.tap(addButton);
    await tester.pump();

    // Check the outputs
    expect(find.text('Hamburger'), findsOneWidget);
    expect(find.text('8.99'), findsOneWidget);
    expect(find.text('Food'), findsOneWidget);
  });
}
