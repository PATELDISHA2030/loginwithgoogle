import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'next_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account != null) {
        final String? displayName = account.displayName;
        final String email = account.email;
        final String? photoUrl = account.photoUrl;

        // Save user data locally
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('displayName', displayName ?? '');
        await prefs.setString('email', email);
        await prefs.setString('photoUrl', photoUrl ?? '');

        // Navigate to next page
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NextPage()),
          );
        }
      } else {
        // Sign-in cancelled
        print('User cancelled Google Sign-In.');
      }
    } catch (error) {
      print('Google Sign-In error: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login with Google")),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.login),
          label: const Text("Sign in with Google"),
          onPressed: signInWithGoogle,
        ),
      ),
    );
  }
}
