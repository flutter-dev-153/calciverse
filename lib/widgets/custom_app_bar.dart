import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final double height;

  CustomAppBar({this.title, this.height});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: height / 2.1),
        ),
      ),
    );
  }
}
