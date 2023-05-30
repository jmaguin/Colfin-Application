import 'package:flutter/material.dart';
import 'package:flutter_finance_app/pages/home_page.dart';
import 'package:flutter_finance_app/pages/login_page.dart';
import 'package:flutter_finance_app/pages/coupon_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_finance_app/pages/data_constant.dart';
import 'package:flutter_finance_app/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set persistent values
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('itemCount', 0);
  await prefs.setString('profileName', "Eric Huang");
  await prefs.setString('profileRole', "Software Developer");
  await prefs.setString('profileEmail', "yhuang7@scu.edu");
  await prefs.setDouble('profileFund', 6000.00);
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
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: HomePage(),
    );
  }
}
