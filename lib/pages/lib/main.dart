// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:ljm/main.dart';
import 'constant/app_color.dart';
import 'package:flutter/services.dart';
import 'views/screens/welcome_page.dart';

void main() async {
  await awalApp();
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColor.primary,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Nunito',
      ),
      home: const WelcomePage(),
    );
  }
}

class Pecahan {
  static String rupiah({required int value, required bool withRp}) {
    final String hasil = NumberFormat("#,###").format(value).replaceAll(",", ".");
    return !withRp ? hasil : "Rp $hasil";
  }

  static String rupiahsd(double? value, double? value2, {bool withRp = true}) {
    final String hasil = NumberFormat("#,###").format(value).replaceAll(",", ".");
    final String hasil2 = NumberFormat("#,###").format(value2).replaceAll(",", ".");
    if ((double.tryParse(value.toString()) == double.tryParse(value2.toString()))) return !withRp ? hasil : "Rp $hasil";
    return !withRp ? "$hasil - $hasil2" : "Rp $hasil - Rp $hasil2";
  }
}
