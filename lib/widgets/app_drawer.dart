import 'package:flutter/material.dart';

import '../screens/more_tools/linear_equations/linear_equations_screen.dart';
import '../screens/more_tools/quadratic_equations_screen.dart';

class AppDrawer extends StatelessWidget {
  static const listItems = [
    {'displayText': 'Home', 'routeName': '/'},
    {'displayText': 'Linear Equations', 'routeName': LinearEquationsScreen.routeName },
    {'displayText': 'Quadratic Equations', 'routeName': QuadraticEquationsScreen.routeName},
  // Matrix operations: inverse, co-factors
//    {'displayText': 'Combinatorics', 'routeName': '/'},
  // Converters
  ];

  Widget buildListItem(
    BuildContext context,
    String displayText,
    String onPressedRoute,
  ) {
    return ListTile(
      title: Text(displayText),
      onTap: () {
        // Pop the drawer
        Navigator.of(context).pop();

        Navigator.of(context).pushReplacementNamed(onPressedRoute);
      },
    );
  }

  List<Widget> getWidgetList(BuildContext context) {
    final list = <Widget>[];

    listItems.forEach((item) {
      list.add(buildListItem(
        context,
        item['displayText'],
        item['routeName'],
      ));
      list.add(Divider());
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final listWidgetItems = getWidgetList(context);

    return Drawer(
      elevation: 5,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('More tools'),
            automaticallyImplyLeading: false,
            // don't display back button
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => listWidgetItems[index],
              itemCount: listWidgetItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
