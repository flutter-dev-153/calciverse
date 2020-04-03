import 'package:calciverse/screens/more_tools/linear_equations/linear_equations_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  static const listItems = [
    {'displayText': 'Home', 'routeName': '/'},
    {'displayText': 'Linear Equations', 'routeName': LinearEquationsScreen.routeName },
//    {'displayText': 'Quadratic Equations', 'routeName': '/'},
//    {'displayText': 'Combinatorics', 'routeName': '/'},
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
