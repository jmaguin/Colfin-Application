import 'package:flutter/material.dart';
import 'package:flutter_finance_app/pages/daily_page.dart';
import 'package:flutter_finance_app/pages/home_page.dart';
import 'package:flutter_finance_app/pages/login_page.dart';
import 'package:flutter_finance_app/pages/coupon_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_finance_app/pages/data_constant.dart';
import 'package:flutter_finance_app/database.dart';

void main() async{
  runApp(const MyApp());
  // Future<List<DataObj>> test = convertPurchaseList();
  // List<DataObj> test_list = await test;
  // static double total = 0;
  // for(int i = 0; i < test_list.length; i++){
  //   total += test_list[i].price;
  // }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: HomePage(),
    );
  }
}
