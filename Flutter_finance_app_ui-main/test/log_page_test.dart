
// Test file for log page.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_finance_app/pages/log_page.dart';

void main() {
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(), child: new MaterialApp(home: new LogPage()));

  testWidgets('Item Text test', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Text("Item:", key: Key('itemText'))));
    var finder = find.byKey(Key("itemText"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "Item:");
  });

  testWidgets('Item Field Text test', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Text("Enter name", key: Key('nameField'))));
    var finder = find.byKey(Key("nameField"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "Enter name");
  });

  testWidgets('Price Text test', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Text("Price:", key: Key('priceText'))));
    var finder = find.byKey(Key("priceText"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "Price:");
  });

  testWidgets('Price Field Text test', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Text("Enter price", key: Key('priceField'))));
    var finder = find.byKey(Key("priceField"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "Enter price");
  });

  testWidgets('Category Text test', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Text("Category:", key: Key('categoryText'))));
    var finder = find.byKey(Key("categoryText"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "Category:");
  });

  testWidgets('Category Dropdown Text test', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Text("Food", key: Key('dropdownButtonText'))));
    var finder = find.byKey(Key("dropdownButtonText"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "Food");
  });

  testWidgets('Add Item Button Text test', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Text("Add Item", key: Key('addItemText'))));
    var finder = find.byKey(Key("addItemText"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "Add Item");
  });

  testWidgets('Add Item Button Function test', (WidgetTester tester) async {
    // Tap Add Item button
    // final addButton = find.byType(GestureDetector);
    // final nameField = find.text("Enter Name");
    // final priceField = find.text("Enter Price");

    final addButton = find.byKey(ValueKey("addItemButton"));
    final nameField = find.byKey(ValueKey("nameField"));
    final priceField = find.byKey(ValueKey("priceField"));

    await tester.pumpWidget(testWidget);
    await tester.enterText(nameField, "Hamburger");
    await tester.enterText(priceField, "8.99");
    await tester.tap(addButton);
    await tester.pump();

    // Check the outputs
    expect(find.text('Hamburger'), findsOneWidget);
    expect(find.text('8.99'), findsOneWidget);
    expect(find.text('Food'), findsOneWidget);
  });
}

