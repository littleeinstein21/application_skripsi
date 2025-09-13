import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController =
      TextEditingController(text: "book_lover");
  final TextEditingController passwordController =
      TextEditingController(text: "123456");

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C54),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.person, size: 100, color: Colors.white),
            const SizedBox(height: 30),
            _buildTextField("Username", usernameController),
            const SizedBox(height: 20),
            _buildTextField("Password", passwordController, obscureText: true),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke dashboard saat berhasil login
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('MASUK'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        border: const OutlineInputBorder(),
        // ignore: prefer_const_constructors
        enabledBorder: OutlineInputBorder(
          // ignore: prefer_const_constructors
          borderSide: BorderSide(color: Colors.white38),
        ),
        // ignore: prefer_const_constructors
        focusedBorder: OutlineInputBorder(
          // ignore: prefer_const_constructors
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
    );
  }
}
