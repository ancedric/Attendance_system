import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import '../home_page.dart';
import '../../storage/local_storage.dart';
import 'login_page.dart'; // Import LoginPage

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController(); // Added password controller
  final confirmPasswordController =
      TextEditingController(); // Added confirm password controller

  void signup() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Password must be at least 6 characters")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final userRef = 'USER_${prefs.getInt('userCount') ?? 0}'; // Generate userRef
    await LocalStorage.saveUser(
      userRef,
      nameController.text,
      emailController.text,
      passwordController.text, // Save the password
    );

    // Increment userCount for the next user
    prefs.setInt('userCount', (prefs.getInt('userCount') ?? 0) + 1);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Inscription réussie")),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name")),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email")),
            TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true),
            TextField(
                controller: confirmPasswordController,
                decoration:
                    const InputDecoration(labelText: "Confirm Password"),
                obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: signup, child: const Text("Sign Up")),
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LoginPage())),
              child: const Text("Already have an account? Login"),
            )
          ],
        ),
      ),
    );
  }
}