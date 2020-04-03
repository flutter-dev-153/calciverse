import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello, Friend!'),
            automaticallyImplyLeading: false,
            // don't display back button
          ),
//          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
