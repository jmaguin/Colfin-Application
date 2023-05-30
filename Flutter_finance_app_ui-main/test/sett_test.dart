import 'package:flutter/material.dart';
import 'package:flutter_finance_app/pages/settings_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;


void main(){
//   Widget testWidget = new MediaQuery(
//       data: new MediaQueryData(),
//       child: new MaterialApp(home: new SettPage())
// );
  testWidgets('Name Textbox test', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: const SettPage()));
    final name_field = find.byKey(Key('nameField'));
    await tester.enterText(name_field, "testing");
    expect(find.text("testing"), findsOneWidget);
  });
  testWidgets('Role Textbox test', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: const SettPage()));
    final role_field = find.byKey(Key('roleField'));
    await tester.enterText(role_field, "testing");
    expect(find.text("testing"), findsOneWidget);
  });
  testWidgets('Email Textbox test', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: const SettPage()));
    final email_field = find.byKey(Key('emailField'));
    await tester.enterText(email_field, "testing");
    expect(find.text("testing"), findsOneWidget);
  });
  testWidgets('Monthly Textbox test', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: const SettPage()));
    final monthly_field = find.byKey(Key('monthlyField'));
    await tester.enterText(monthly_field, "testing");
    expect(find.text("testing"), findsOneWidget);
  });

  
}