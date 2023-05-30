import 'package:flutter_finance_app/pages/coupon_page.dart';
import 'package:flutter_finance_app/pages/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
//import 'package:test/test.dart';
import 'package:flutter/cupertino.dart';

void main(){
  testWidgets('Testing go back button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CouponPage()));
    await tester.tap(find.byIcon(CupertinoIcons.back));
    await tester.pump();
    print('Found go back button');

  });
  test('Testing ApiConstant class', (){
    final Api = ApiConstant(title: 'MacBook', salePrice: '2000', savings: '20');

    expect(Api.title, 'MacBook');
    expect(Api.salePrice, '2000');
    expect(Api.savings, '20');
  });

  test('Testing API connectivity', (){
    late Future<List<ApiConstant>> futureAlbum = fetchAlbum();
    expect(futureAlbum, completes);
  });

  

}