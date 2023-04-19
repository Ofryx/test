import 'package:flutter/material.dart';
import 'dart:io';
import 'package:misis/pages/test_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    String? username = userEmail?.split('@').first;

    return Container(
      width: 200,
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/image/Logo.jpg"),
                  backgroundColor: Colors.blue.shade800,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                   'ID: ${username ?? ''}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,

                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsPage()),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.newspaper,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Новости",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Профиль",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Настройки",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    exit(0);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Выход",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
