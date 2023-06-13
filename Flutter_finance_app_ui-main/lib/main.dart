import 'package:flutter/material.dart';
import 'package:flutter_finance_app/pages/home_page.dart';
import 'package:flutter_finance_app/pages/login_page.dart';
import 'package:flutter_finance_app/pages/coupon_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_finance_app/pages/data_constant.dart';
import 'package:flutter_finance_app/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_finance_app/pages/notification.dart';
final NotificationService nm = NotificationService();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await nm.initNotification();
  //await NotificationService().init();

  runApp(const MyApp());

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
