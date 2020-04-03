import 'package:flutter/material.dart';

import 'package:calciverse/widgets/app_drawer.dart';
import 'package:calciverse/widgets/custom_app_bar.dart';

import './2_by_2_linear_equations_solver_screen.dart';
import './3_by_3_linear_equations_solver_screen.dart';

class LinearEquationsScreen extends StatefulWidget {
  static const routeName = '/linear-equations';
  static const title = 'Linear Equations';

  static const linearEquationsTypes = const [
    const {'displayText': '2 X 2 solver', 'routeName': TwoByTwoLinearEquationsSolverScreen.routeName},
    const {'displayText': '3 X 3 solver', 'routeName': ThreeByThreeLinearEquationsSolverScreen.routeName},
  ];

  @override
  _LinearEquationsScreenState createState() => _LinearEquationsScreenState();
}

class _LinearEquationsScreenState extends State<LinearEquationsScreen> {
  double viewHeight = 0;
  double viewWidth = 0;

  Widget getBody() {
    final themeData = Theme.of(context);
    const items = LinearEquationsScreen.linearEquationsTypes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(item['routeName']);
                },
                child: Text(
                  item['displayText'],
                  style: TextStyle(
                    color: themeData.accentColor,
                    fontSize: 20,
                  ),
                ),
                color: themeData.primaryColor,
                height: 60,
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    viewHeight = mediaQuery.size.height - mediaQuery.padding.top;
    viewWidth = mediaQuery.size.width;

    final appBarHeight = viewHeight * 0.1;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: LinearEquationsScreen.title,
          height: appBarHeight,
        ),
        drawer: AppDrawer(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: viewHeight - appBarHeight,
          child: getBody(),
        ),
      ),
    );
  }
}
