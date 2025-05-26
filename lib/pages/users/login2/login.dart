// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/env/env.dart';
import 'package:ljm/main.dart';
import 'package:ljm/provider/database/query.dart';
import 'package:ljm/provider/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ljm/tools/env.dart';

import 'sign_in_button/stub.dart';

final List<String> scopes = <String>[
  'https://www.googleapis.com/auth/userinfo.profile',
  'https://www.googleapis.com/auth/userinfo.email',
];
final googleSignIn = (kIsWeb) ? GoogleSignIn(clientId: Env.GOOGLESIGNINWEBCLIENTID, scopes: scopes) : GoogleSignIn(scopes: ['email', 'profile']);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// has granted permissions?
  final TextEditingController namaController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget _entryField(TextEditingController controller, String title, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(
            height: 4,
          ),
          TextField(
            controller: controller,
            obscureText: isPassword,
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        final user = await loginWithUsernameAndPassword(
          namaController.text,
          passwordController.text,
        );
        if (user != null) {
          saveLoginStatus(true, user);
          Get.snackbar('Pemberitahuan', 'Login successful.');
          Get.off(() => const wellcome());
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(user: user));
        } else {
          Get.snackbar('Pemberitahuan', 'Login failed. Please try again.');
        }
      },
      child: Container(
        // width: MediaQuery.of(context).size.width,
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        // decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)), boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: const Offset(2, 4), blurRadius: 5, spreadRadius: 2)], gradient: const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        decoration: BoxDecoration(
          color: Color(0xFF00b3b0),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          'Masuk',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
          // style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return Image.asset(
      'assets/logoleonwarna.png',
      fit: BoxFit.cover,
      height: 200,
      width: 200,
    );
    //---punya wak upi---
    // Widget _title() {
    //   return RichText(
    //     textAlign: TextAlign.center,
    //     text: TextSpan(
    //         text: 'Lucky',
    //         style: GoogleFonts.portLligatSans(
    //           textStyle: Theme.of(context).textTheme.displayLarge,
    //           fontSize: 25,
    //           fontWeight: FontWeight.w700,
    //           color: Colors.black,
    //         ),
    //         children: [
    //           TextSpan(text: 'Jaya', style: GoogleFonts.zeyada(color: Colors.deepOrange, fontSize: 40)),
    //           const TextSpan(
    //             text: 'Motorindo',
    //             style: TextStyle(color: Colors.black45, fontSize: 25),
    //           ),
    //         ]),
    //   );
    // }
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(namaController, "Email / No. Handphone"),
        _entryField(passwordController, "Password", isPassword: true),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      dp("googleSignIn.onCurrentUserChanged.listen ${account}");
      bool isAuthorized = account != null;
      if (isAuthorized) loginWithGoogle(account);
      /* if (kIsWeb && account != null) {
        isAuthorized = await googleSignIn.canAccessScopes(scopes);
      } */
      // setState(() {});

      /*      /*   if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      } */
      try {
        // ignore: unused_local_variable
        GoogleSignInAuthentication googleSignInAuthentication = await account!.authentication;
        String? serverAuthToken = account.serverAuthCode;
        dp(serverAuthToken);
      } catch (e) {
        dp("error GoogleSignInAuthentication: $e");
      } */
    });

    /*  try {
      if (kIsWeb) googleSignIn.signInSilently();
    } catch (e) {
      dp("error signInSilently: $e");
    } */
  }

/*   Future<void> _handleGetContact(GoogleSignInAccount user) async {
    dp("_handleGetContact");
    setState(() {});
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {});
      dp('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
      } else {}
    });
  } */

/*   String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
        (dynamic name) => (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),

          title: Text('Login'),
          // toolbarHeight: 10,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _title(),
                const SizedBox(height: 60),
                _emailPasswordWidget(),
                // const SizedBox(height: 20),
                SizedBox(
                  height: 20,
                ),
                _submitButton(),
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   alignment: Alignment.centerRight,
                //   child: const Text('Forgot Password ?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                // ),
                // _divider(),
                //_facebookButton(),
                buildSignInButton(
                  onPressed: _handleSignIn,
                ),
                // _createAccountLabel(),
              ],
            ),
          ),
        ));
  }
}

Future<void> saveLoginStatus(bool isLoggedIn, [User? user]) async {
  prefs.setBool('isLoggedIn', isLoggedIn);
  if (isLoggedIn && user != null) {
    prefs.setString('email', user.email ?? '');
  } else {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
    prefs.remove('email');
  }
}

getUser(String email, [String? image]) async {
  dp('getuser');

  var xuser = await getUserByID(email);
  xuser?.fileGambar = image;
  return xuser;
}

/* getoperator(String email) async {
  var url = '$urlBase/opr.php';
  var response = await postResponse(url, {"id": email});
  dp('Sales API ${response.statusCode} response: ${response.body}');
  if (response == null) return;
  List jsonResponse = response.body;
  if (response.statusCode == 200) {
    if (jsonResponse.isNotEmpty) {
      user = jsonResponse.map((job) => User.fromMap(job)).first;
    }
  }
} */

Future<void> _handleSignIn() async {
  dp('_handleSignIn');
  // (kIsWeb) ? await googleSignIn.signInSilently() :
  await googleSignIn.signIn();
  // var account = await googleSignIn.signInSilently();
  // user = await loginWithGoogle(account) ?? User();
}

Future<User?> loginWithGoogle(GoogleSignInAccount? account) async {
  dp('loginWithGoogle $account');
  if (account == null) {
    dp('re');
    return null; // Login dibatalkan
  }

  // ignore: unused_local_variable
  // final authentication = await account.authentication;
  final profileImageUrl = account.photoUrl;
  try {
    if (profileImageUrl != null) {
      final response = await http.get(Uri.parse(profileImageUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final localFilePath = '${pathData}profile_image.jpg';
        final file = File(localFilePath);
        await file.writeAsBytes(bytes);
        prefs.setString('profile_image_path', localFilePath);
        prefs.setString('profileImageUrl', profileImageUrl);
        dp("set profileImageUrl=>$profileImageUrl");
      } else {
        // Handle jika unduhan gambar profil gagal
        Get.snackbar('Pemberitahuan', 'Lunduhan gambar profil gagal');
      }
    }
  } catch (e) {
    dp("error: http.get(Uri.parse($profileImageUrl)/n$e");
  }

  var auser = await getUser(account.email, profileImageUrl);
  if (auser != null) {
    user = auser;
    usertoPrefs(user);
  } else {
    user = User(email: account.email, idkontak: 0, imageurl: account.photoUrl, nama: account.displayName, tipe: 6);

    //user?.simpanLocal();
    usertoPrefs(user);
  }

  saveLoginStatus(true, user);
  if (user.email != null) {
    Get.snackbar('Pemberitahuan', 'Login with Google successful.');
    Get.offAll(() => const wellcome());
  } else {
    Get.snackbar('Pemberitahuan', 'Login with Google failed.');

    saveLoginStatus(false);
    await googleSignIn.signOut();
  }
  return user;
}

Future<User?> loginWithUsernameAndPassword(String nama, String password) async {
  var auser = await getUser(nama);
  // var auser = listUser.firstWhereOrNull((element) => element.email == nama || element.nama == nama);
  if (auser != null) {
    if (auser.imageurl.toString().trim() != '') {
      try {
        final response = await http.get(Uri.parse(auser.imageurl ?? ''));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          salesAktif = user.kontak;
          // if (salesAktif != null) prefs.setString("salesAktif", salesAktif!.toJson());
          final localFilePath = '${pathData}profile_image.jpg';
          final file = File(localFilePath);
          await file.writeAsBytes(bytes);
          prefs.setString('profile_image_path', localFilePath);
        } else {
          Get.snackbar('Pemberitahuan', 'Lunduhan gambar profil gagal');
        }
      } catch (e) {
        Get.snackbar('Pemberitahuan', 'Lunduhan gambar profil gagal');
      }
    }
  }

  return auser;
}

handleSignOut() async {
  dp("handleSignOut");
  if (await googleSignIn.isSignedIn()) {
    await googleSignIn.signOut();
  }
  prefs.clear();
  user = User();
  dp("handleSignOut d");

  Get.offAll(() => const wellcome());
}
