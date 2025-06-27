import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String name = '';
  String email = '';
  String photo = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('displayName') ?? '';
      email = prefs.getString('email') ?? '';
      photo = prefs.getString('photoUrl') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (photo.isNotEmpty)
              CircleAvatar(
                backgroundImage: NetworkImage(photo),
                radius: 40,
              ),
            const SizedBox(height: 20),
            Text("Name: $name", style: const TextStyle(fontSize: 20)),
            Text("Email: $email", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
