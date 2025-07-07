import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semester_5_labs/practise_code/crud_with_middleware_getx/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void _loginUser() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username == "admin" && password == "1234") {
      authService.login();
      Get.offAllNamed('/home');
      Get.snackbar("Login Success", "Welcome back, $username!");
    } else {
      Get.snackbar("Login Failed", "Invalid credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginUser,
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
