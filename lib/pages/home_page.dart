import 'dart:math';
import 'package:flutter/material.dart';
import 'package:misis/components/SideMenu.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.blue.shade400,
                  Colors.blue.shade800,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
          ),
          SafeArea(
            child: SideMenu(),
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: value),
            duration: Duration(milliseconds: 250),
            builder: (BuildContext context, double val_, Widget? child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val_)
                  ..rotateY((pi / 6) * val_),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(value == 1 ? 30 : 0),
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("МИСиС"),
                      centerTitle: true,
                      backgroundColor: Colors.blue.shade900,
                    ),
                    body: Center(
                      child: Text("Swipe right to open the menu"),
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          )
        ],
      ),
    );
  }
}
