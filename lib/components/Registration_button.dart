import 'package:flutter/material.dart';

class MyButton1 extends StatelessWidget {
  void Function()? onTap1;
  MyButton1({Key? key, required this.onTap1}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap1,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 130),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            "Регистрация",
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}