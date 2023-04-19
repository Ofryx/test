// Главный экран
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:misis/not%20need/firebase_options.dart';
import 'package:misis/pages/Login_page.dart';
import 'package:misis/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Misis());
}

class Misis extends StatelessWidget {
  const Misis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/home': (context) => HomePage()},
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: LoginPage(),
      ),
    );
  }
}
