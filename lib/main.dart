// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
/* import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart'; */
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in_dartio/google_sign_in_dartio.dart';
import 'package:ljm/pages/homepage/admin/controller.dart';
import 'package:ljm/pages/homepage/admin/page.dart';
import 'package:ljm/pages/index.dart';
import 'package:ljm/pages/users/login2/login.dart';
import 'package:ljm/provider/database/query.dart';
import 'package:ljm/provider/socket_controller.dart';
import 'package:ljm/tools/env.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'env/env.dart';
import 'main/utils/media_player_central.dart';
import 'main/utils/notification_util.dart';
import 'pages/homepage/member/page.dart';
import 'pages/homepage/sales/controller.dart';
import 'pages/homepage/sales/page.dart';
import 'pages/homepage/umum/page.dart';
import 'provider/models/user.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'non_web_specific.dart' if (dart.library.html) 'web_specific.dart';
part 'main/awesomenotif.dart';
part 'main/events.dart';

part 'main/repos.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Intl.defaultLocale = 'id_ID';
  prefs = await SharedPreferences.getInstance();
  await awalApp();
  if (!kIsWeb) FlutterNativeSplash.remove();

  setupapp();
  // ver = await getVersion();
  dp("app version: $ver");
  runApp(
    GetMaterialApp(
      supportedLocales: [
        Locale('en', 'US'), // English
        Locale('id', 'ID'), // Bahasa Indonesia
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Lucky Jaya Group',
      theme: customTema,
      getPages: rPage,
      debugShowCheckedModeBanner: false,
      home: const wellcome(),
    ),
  );
}

class wellcome extends StatelessWidget {
  const wellcome({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final isLoggedIn = snapshot.data ?? false;
            if (isLoggedIn && user.email != null) {
              switch (TipeOperator.values[user.tipe]) {
                case TipeOperator.admin:
                  return GetBuilder<DBAdminController>(
                    init: DBAdminController(),
                    builder: (_) {
                      return DBAdmin(user);
                    },
                  );
                case TipeOperator.sales:
                  return GetBuilder<DBSalesController>(
                    init: DBSalesController(),
                    builder: (_) {
                      return DBSales(user);
                    },
                  );
                case TipeOperator.direksi:
                  return GetBuilder<DBAdminController>(
                    init: DBAdminController(),
                    builder: (_) {
                      return DBAdmin(user);
                    },
                  );
                default:
                  dp("default: ${TipeOperator.values[user.tipe]}");
                  return const MemberPage();
              }
            } else {
              return const UmumPage();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Future<bool> checkLoginStatus() async {
    if (kIsWeb) {
      /*   if (kDebugMode) {
        user = User(idkontak: 1, email: "renbang.turenindah@gmail.com");
        await preftoUser(user);
        dp("user (kDebugMode):\n$user");
        return true;
      } */
    }
    var isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      await preftoUser();

      dp("checkLoginStatus $user");
      // await Barang.setLokasi(getidLokasi(), false);
      return true;
    }
    dp("is Not Login");
    return false;
  }
}

Future<User?> preftoUser([User? def]) async {
  dp("preftoUser()");
  try {
    // ignore: unused_local_variable
    var localFilePath = prefs.getString('profile_image_path');
    if (def != null) {
      if (def.email != null) {
        user = await getUserByID(def.email) ?? user;
        salesAktif = user.kontak;
      }
      return user;
    }
    if (prefs.getString('email') != null) {
      var _user = await getUserByID(prefs.getString('email'));
      if (_user != null) {
        user = _user;
        salesAktif = user.kontak;
      } else {
        user = User(email: prefs.getString('email'), idkontak: 0, imageurl: prefs.getString('profileImageUrl') ?? '', tipe: 6);
      }
      return user;
    }
    return null;

    //user = User.fromJson(jsonDecode(prefs.getString('user') ?? ''));
    /* try {
      if (user.email != null) {
        user = await getUserByID(user.email) ?? user;
        if (prefs.getString('salesAktif') != null) salesAktif = KONTAK.fromJson(prefs.getString('salesAktif') ?? '');
      } else {
        if (def?.email != null) {
          user = await getUserByID(def?.email) ?? user;
        }
      } */
  } catch (e, stackTrace) {
    dp("preftoUser kontak e:$e");
    dp("preftoUSer => ${prefs.getString('user')}");
    dp("uSer => $user");
    dp("stackTrace: $stackTrace");
  }
  return user;
}

usertoPrefs(User u) {
  // dp('usertoPrefs($u)');
  // var _auser = u.toJson();  dp("_auser: $_auser");
  // prefs.clear();
  /*
  String? akseslokasi = json.encode(u.akseslokasi);
  String? akseskas = json.encode(u.akseskas);
  String? kontakJson = json.encode(u.kontak);
  String user = json.encode(u);
  */
  prefs.setString('email', u.email ?? '');
  /*
  prefs.setString('nama', u.nama ?? '');
  prefs.setInt('tipe', u.tipe);
  if (u.idkontak != null) prefs.setInt('idkontak', u.idkontak!);
  if (u.idlokasi != null) prefs.setInt('idlokasi', u.idlokasi!);
  prefs.setInt('tipe', u.tipe);
  prefs.setString('imageurl', u.imageurl.toString());
  prefs.setString('akselokasi', akseslokasi);
  prefs.setString('akseskas', akseskas);
  prefs.setString('kontak', kontakJson);
  prefs.setString('user', user);
  */
  //  salesAktif = u.kontak;

  // if (salesAktif != null) prefs.setString("salesAktif", salesAktif!.toJson());
}

awalApp() async {
  dp("_awal");
  HttpOverrides.global = MyHttpOverrides();
  if (kIsWeb) {
    // Change default factory on the web
    // databaseFactory = databaseFactoryFfiWeb;
    // path = 'my_web_web.db';
  } else {
    await getAppDir();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      connectivitySubscription = connectivity.onConnectivityChanged.listen((res) => updateConnectionStatus(res));
      // await initFCMApp();

      // await initAwsApp();
      //  await initTts();
    }
    if (Platform.isWindows) {
      // sqfliteFfiInit();
      await GoogleSignInDart.register(clientId: Env.GOOGLESIGNINCLIENTID);
    }
    initialSocket();
  }
}

Future<String> loadProfileImagePath() async {
  // return '${pathData}profile_image.jpg';
  return prefs.getString('profileImageUrl') ?? '';
}

Widget buildUserHeader() {
  return FutureBuilder<String>(
    future: loadProfileImagePath(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return UserAccountsDrawerHeader(
          accountName: Text(getUserName(), style: Theme.of(context).textTheme.titleLarge),
          accountEmail: Text(getEmail(), style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF00b3b0))),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.black,
            // backgroundImage: FileImage(File(profileImagePath)),
            child: Image.asset('assets/logoleonputih.png'),
          ),
        );
      } else {
        return UserAccountsDrawerHeader(
          accountName: Text(getUserName()),
          accountEmail: Text(getEmail()),
          currentAccountPicture: const CircleAvatar(
            child: Icon(Icons.person),
          ),
        );
      }
    },
  );
}

Widget buildUserAvatar() {
  return FutureBuilder<String>(
    future: loadProfileImagePath(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final profileImagePath = snapshot.data ?? '';
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: FileImage(File(profileImagePath)),
          ),
        );
      } else {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Icon(
              Icons.list_rounded,
              color: Colors.white,
            ),
          ),
        );
      }
    },
  );
}

void handleLogout() {
  saveLoginStatus(false);

  Get.offAll(() => const wellcome());
}
