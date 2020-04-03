import 'package:flutter/material.dart';

import '../../../widgets/app_drawer.dart';
import '../../../widgets/custom_app_bar.dart';
import './inverse_of_a_matrix_screen.dart';
import './co_factors_of_matrix_screen.dart';

class MatrixOperationsScreen extends StatefulWidget {
  static const routeName = '/matrix-operations';
  static const title = 'Matrix Operations';

  static const matrixOperationsTypes = const [
    const {'displayText': 'Inverse', 'routeName': InverseOfAMatrixScreen.routeName},
    const {'displayText': 'Co-factors', 'routeName': CoFactorsOfAMatrixScreen.routeName},
  ];

  @override
  _MatrixOperationsScreenState createState() => _MatrixOperationsScreenState();
}

class _MatrixOperationsScreenState extends State<MatrixOperationsScreen> {
  Widget getBody() {
    final themeData = Theme.of(context);
    const items = MatrixOperationsScreen.matrixOperationsTypes;

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
    final viewHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final viewWidth = mediaQuery.size.width;

    final appBarHeight = viewHeight * 0.1;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: MatrixOperationsScreen.title,
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
