import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final double height;

  CustomAppBar({this.title, this.height});

  @override
  Widget get child => null;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      height: preferredSize.height,
      color: themeData.primaryColor,
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: height / 2.1,
                color: themeData.accentColor,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
