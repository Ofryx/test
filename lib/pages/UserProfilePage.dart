import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;

  const UserProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late String _email; // Declare a late String variable for email

  @override
  void initState() {
    super.initState();
    _getEmail(); // Call the method to get the user's email
  }

  Future<void> _getEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email ?? ''; // Get the email or an empty string
      setState(() {
        _email = email; // Update the state of the _email variable
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userEmailWithoutDomain = _email.replaceFirst('@gmail.com', '');
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Email: ${userEmailWithoutDomain}',
        ), 
      ),
    );
  }
}
