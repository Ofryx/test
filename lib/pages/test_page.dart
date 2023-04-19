import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Новости"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Container(
          child: Text("News"),
        ),
      ),
    );
  }
}
