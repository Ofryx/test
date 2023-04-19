import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:misis/pages/Login_page.dart';
import 'package:misis/pages/home_page.dart';



class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Пользователь вошел в систему
          if (snapshot.hasData) {
            return  HomePage();
          }
          // Пользователь не зашел в систему
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}


