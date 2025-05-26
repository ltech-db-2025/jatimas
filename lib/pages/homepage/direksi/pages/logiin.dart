// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ljm/tools/env.dart';

class DireksiPage extends StatelessWidget {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  DireksiPage({super.key});

  void _signInWithEmail(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    try {
      // If login is successful, you can navigate to the next page.
      // Navigator.push...
    } catch (e) {
      // Handle login errors
      dp("Error signing in with email: $e");
    }
  }

  void _signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        /*  //AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential = await _auth.signInWithCredential(credential); */
        // If login is successful, you can navigate to the next page.
        // Navigator.push...
      }
    } catch (e) {
      // Handle login errors
      dp("Error signing in with Google: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50, // Adjust the size of the logo here
              backgroundImage: AssetImage("assets/logo.png"), // Replace with your logo image
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: () => _signInWithEmail(context),
              child: const Text("Login with Email"),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () => _signInWithGoogle(context),
              icon: Image.asset("assets/google.png", height: 18, width: 18),
              label: const Text("Login with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
