import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Auth_controller.dart';


class RegisterScreen1 extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  RegisterScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _authController.registerUser(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                  _usernameController.text.trim(),
                );
              },
              child: Text('Register'),
            ),
            SizedBox(height: 30,),
            GestureDetector(onTap:(){
              Get.toNamed("/login");
            },child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
