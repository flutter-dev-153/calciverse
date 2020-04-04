import 'package:flutter/material.dart';

import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/app_drawer.dart';
import './permutations_screen.dart';
import './combinations_screen.dart';
import './multinomial_coefficients_screen.dart';

class CombinatoricsScreen extends StatefulWidget {
  static const routeName = '/combinatorics';

  static const combinatoricsSubTypes = const [
    const {'displayText': 'Permutations', 'routeName': PermutationsScreen.routeName},
    const {'displayText': 'Combinations', 'routeName': CombinationsScreen.routeName},
    const {'displayText': 'Multinomial Coefficient', 'routeName': MultinomialCoefficientsScreen.routeName},
  ];

  @override
  _CombinatoricsScreenState createState() => _CombinatoricsScreenState();
}

class _CombinatoricsScreenState extends State<CombinatoricsScreen> {
  Widget getBody() {
    final themeData = Theme.of(context);
    const items = CombinatoricsScreen.combinatoricsSubTypes;

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
    final appBarHeight = viewHeight * 0.1;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Combinatorics',
          height: appBarHeight,
        ),
        drawer: AppDrawer(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: viewHeight - appBarHeight,
          child: getBody(),
        ),
      ),
    );
  }
}
