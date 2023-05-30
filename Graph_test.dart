import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance_app/pages/graph.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  testWidgets('SFCartesianGraph renders correctly', (WidgetTester tester) async {
    // Create a minimal test widget

    await tester.pumpWidget(MaterialApp(home: GraphPage()));

    // Verify the expected behavior
    // Example: Verify that the graph is rendered on the screen
    expect(find.byType(SfCartesianChart), findsOneWidget);
  });
}


