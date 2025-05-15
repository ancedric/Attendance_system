import 'package:flutter/material.dart';
import 'auth/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    });

    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Smart ATS", style: TextStyle(fontSize: 36, color: Colors.white)),
            Text("The easy way to mark your presence", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
