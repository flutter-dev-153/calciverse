import 'package:flutter/material.dart';

import '../../../widgets/app_drawer.dart';
import '../../../widgets/custom_app_bar.dart';
import './is_prime_screen.dart';
import './highest_common_factor_screen.dart';

class MiscellaneousScreen extends StatefulWidget {
  static const routeName = '/miscellaneous-screen';

  static const miscellaneousTools = const [
    const {'displayText': 'Is Prime', 'routeName': IsPrimeScreen.routeName},
    const {'displayText': 'Least common multiple', 'routeName': ''},
    const {'displayText': 'Highest common Factor', 'routeName': HighestCommonFactorScreen.routeName},
    const {'displayText': 'Mean of numbers', 'routeName': ''},
  ];

  @override
  _MiscellaneousScreenState createState() => _MiscellaneousScreenState();
}

class _MiscellaneousScreenState extends State<MiscellaneousScreen> {
  Widget getBody() {
    final themeData = Theme.of(context);
    const items = MiscellaneousScreen.miscellaneousTools;

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
          title: 'Miscellaneous',
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
