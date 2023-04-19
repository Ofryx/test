import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:misis/components/Registration_button.dart';
import 'package:misis/components/in_button.dart';
import 'package:misis/components/my_textfield.dart';
import 'package:misis/pages/Registration_page.dart';
import 'dart:io';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Login attempts counter
  int loginAttempts = 0;

  void signUserIn(BuildContext context) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '${emailController.text}@gmail.com',
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        // Navigate to the home page on success
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Handle login error
        // Increment login attempts
        loginAttempts++;

        if (loginAttempts >= 2) {
          // Disable the login button after two unsuccessful attempts
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You have exceeded the maximum login attempts."),
            ),
          );
        } else {
          // Show a snackbar if user is null
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("The user is null."),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Show a snackbar if user is not found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The user is not found."),
          ),
        );
      } else if (e.code == 'wrong-password') {
        // Increment login attempts
        loginAttempts++;

        if (loginAttempts >= 2) {
          // Disable the login button after two unsuccessful attempts
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You have exceeded the maximum login attempts."),
            ),
          );
        } else {
          // Show a snackbar if the password is wrong
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("The password is incorrect."),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Container(
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/Adm.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Введите свой ID",
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: "Введите пароль",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                // forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Забыли пароль?",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
                // sign in button
                const SizedBox(height: 10),

                MyButton(
                  onTap: () => signUserIn(context),
                ),

                const SizedBox(height: 30),

                MyButton1(
                  onTap1: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
