// Test file for log page.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_finance_app/pages/log_page.dart';

void main() {
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: new LogPage())
);
  testWidgets('Log Page widgets test', (WidgetTester tester) async {
    // Get "Add Item" button and text fields
    // final addButton = find.byKey(ValueKey("addItemButton"));
    // final nameField = find.byKey(ValueKey("nameField"));
    // final priceField = find.byKey(ValueKey("priceField"));
    final addButton = find.byType(GestureDetector);
    final nameField = find.text("Enter Name");
    final priceField = find.text("Enter Price");
    await tester.pumpWidget(testWidget);

    // Verify that name, price, and category text fields exist
    expect(find.text('Enter Name'), findsOneWidget);
    expect(find.text('Enter Price'), findsOneWidget);
    expect(find.text('Food'), findsOneWidget);
  });
  // testWidgets('Log Page text field test', (WidgetTester tester) async {
  //   final nameField = find.text("Enter Name");
  //   final priceField = find.text("Enter Price");
  //   await tester.pumpWidget(testWidget);
  //   await tester.enterText(nameField, "Hamburger");
  //   await tester.enterText(priceField, "8.99");

  //   // Verify Add Item button exists
  //   expect(find.text('Add Item'), findsOneWidget);

  // });
    testWidgets('Log Page text field test', (WidgetTester tester) async {
      // Tap Add Item button
    final addButton = find.byType(GestureDetector);
    final nameField = find.text("Enter Name");
    final priceField = find.text("Enter Price");

    await tester.pumpWidget(testWidget);
    await tester.enterText(nameField, "Hamburger");
    await tester.enterText(priceField, "8.99");
    await tester.tap(addButton);
    await tester.pump();

    // Check the outputs
    expect(find.text('Hamburger'), findsNWidgets(2));
    expect(find.text('8.99'), findsNWidgets(2));
    expect(find.text('Food'), findsNWidgets(2));
    });

    // // Tap Add Item button
    // await tester.tap(addButton);
    // await tester.pump();

    // // Check the outputs
    // expect(find.text('Hamburger'), findsNWidgets(2));
    // expect(find.text('8.99'), findsNWidgets(2));
    // expect(find.text('Food'), findsNWidgets(2));
  
}
