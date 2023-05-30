import 'dart:ui';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance_app/pages/home_page.dart';
import 'package:flutter_finance_app/pages/log_page.dart';
import 'package:flutter_finance_app/pages/daily_page.dart';
//import 'package:test/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_finance_app/pages/settings_page.dart';
import  'package:intl/intl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_finance_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_finance_app/pages/data_constant.dart';

void main(){
  test('Home page time', (){
    String date = DateFormat("MMM dd, yyyy").format(DateTime.now());
    expect(date, DateFormat("MMM dd, yyyy").format(DateTime.now()));
  });

  testWidgets('Bottom navigation bar test', (WidgetTester tester) async{
    List<IconData> iconItems = [
      CupertinoIcons.home,
      CupertinoIcons.creditcard,
      CupertinoIcons.money_dollar,
      CupertinoIcons.person,
    ];
    var finder = find.byKey(Key('bottom'));
    //final RenderBox home = tester.renderObject(find.byType(AnimatedBottomNavigationBar));

    print('Found navigation bar');
  });

  testWidgets('Expenses Text test', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: Text("\$4810", key: Key('CashAvail'))));
    var finder = find.byKey(Key("CashAvail"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "\$4810");
    
  });

  testWidgets('Cash Available Text test', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: Text("\$1990", key: Key('expense'))));
    var finder = find.byKey(Key("expense"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "\$1990");
    
  });

  testWidgets('Name Text test', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: Text("Eric Huang", key: Key('name'))));
    var finder = find.byKey(Key("name"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "Eric Huang");
    
  });

  testWidgets('RoleText test', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: Text("Software Developer", key: Key('role'))));
    var finder = find.byKey(Key("role"));
    var text = finder.evaluate().single.widget as Text;
    print(text.data);
    expect(text.data, "Software Developer");
    
  });
  testWidgets('Profile button test', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: GestureDetector(child: Icon(Icons.more_vert),key: Key('Settings'))));
    final Finder iconFinder = find.byIcon(Icons.more_vert);
    await tester.tap(iconFinder);
    await tester.pump();
    print("page found!");
  });
  




  
}