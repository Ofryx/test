import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // Вход пользователя
  void Function()? onTap;

  MyButton({Key? key, required this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 130),
        decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            "Войти",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

