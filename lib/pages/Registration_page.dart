import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:misis/pages/home_page.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final DatabaseReference databaseRef;

  String? _email, _password, _confirmPassword;
  static String? _firstName, _lastName, _group;

  Future<void> _submit() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();

      if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Passwords do not match"),
          ),
        );
        return;
      }

      try {
        final authResult =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );

        final user = authResult.user;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .set({
          'firstName': _firstName,
          'lastName': _lastName,
          'group': _group,
        });

        // Save user data in Realtime Database
        await databaseRef.child(user!.uid).set({
          'firstName': _firstName,
          'lastName': _lastName,
          'group': _group,
        });

        // Navigate to HomePage after user data has been saved in Firestore
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    databaseRef = FirebaseDatabase.instance.reference().child("users");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Регистрация"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      focusColor: Colors.indigo,
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                      labelText: "ID",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[\\@]|\\.com')),
                    ],
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "ID is required";
                      }
                      return null;
                    },
                    onSaved: (value) => _email = "$value@gmail.com",
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                      labelText: "Пароль",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Password is required";
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                      labelText: "Повторите пароль",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please confirm your password";
                      }
                      return null;
                    },
                    onSaved: (value) => _confirmPassword = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                      labelText: "Имя",
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "First name is required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _firstName = value!;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                      labelText: "Фамилия",
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Last name is required";
                      }
                      return null;
                    },
                    onSaved: (value) => _lastName = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                      labelText: "Группа",
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Group is required";
                      }
                      return null;
                    },
                    onSaved: (value) => _group = value,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: Text(
                      "Регистрация",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
