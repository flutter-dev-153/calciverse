import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expression_handler.dart';
import '../providers/history.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/display/calculations_display.dart';
import '../widgets/simple_calculator.dart';
import '../widgets/advanced_calculator.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SimpleCalculator simpleCalculator;
  AdvancedCalculator advancedCalculator;

  MediaQueryData _mediaQuery;
  double _totalHeight = 0;
  double _totalWidth = 0;
  var _isInit = true;
  var _displaySimple = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      _isInit = false;

      _mediaQuery = MediaQuery.of(context);
      _totalHeight = _mediaQuery.size.height - _mediaQuery.padding.top;
      _totalWidth = _mediaQuery.size.width;

      final calculatorButtonsContainerHeight = _totalHeight * 0.46;

      setState(() {
        simpleCalculator = SimpleCalculator(calculatorButtonsContainerHeight);
        advancedCalculator =
            AdvancedCalculator(calculatorButtonsContainerHeight);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      // Set the add-to-history handler in expression handler
      Provider.of<ExpressionHandler>(context, listen: false)
          .setAddToHistoryHandler(
              Provider.of<History>(context, listen: false).addToHistory);
    });
  }

  void swapSimpleAdvancedCalculatorDisplay() {
    setState(() {
      _displaySimple = !_displaySimple;
    });
  }

  Widget getDismissBackground(
    ThemeData themeData,
    CrossAxisAlignment crossAxisAlignment,
    String title,
    IconData iconData, {
    double paddingLeft = 0,
    double paddingRight = 0,
  }) {
    return Container(
      decoration: BoxDecoration(color: themeData.primaryColor),
      child: Padding(
        padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: crossAxisAlignment,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(color: themeData.accentColor, fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: title.length * 15.0,
              child: Center(
                child: Icon(
                  iconData,
                  color: themeData.accentColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final appBarHeight = _totalHeight * 0.1;
    final horizontalPadding = _totalWidth * 0.02;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: widget.title, height: appBarHeight),
        drawer: AppDrawer(),
        drawerEdgeDragWidth: 0,
        // To avoid opening the drawer by swiping from the left edge
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: _totalHeight * 0.01,
          ),
          child: Container(
            height: _totalHeight * 0.9,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: CalculationsDisplay(_totalHeight * 0.40),
                ),
                SizedBox(height: _totalHeight * 0.02),
                if (_displaySimple)
                  Dismissible(
                    key: const ValueKey('simple-calculator'),
                    direction: DismissDirection.startToEnd,
                    background: getDismissBackground(
                      themeData,
                      CrossAxisAlignment.start,
                      'Advanced',
                      Icons.arrow_back,
                      paddingLeft: 20,
                    ),
                    onDismissed: (_) => swapSimpleAdvancedCalculatorDisplay(),
                    child: Padding(
                      padding: EdgeInsets.only(right: horizontalPadding),
                      child: simpleCalculator,
                    ),
                  ),
                if (_displaySimple == false)
                  Dismissible(
                    key: const ValueKey('advanced-calculator'),
                    direction: DismissDirection.endToStart,
                    background: getDismissBackground(
                      themeData,
                      CrossAxisAlignment.end,
                      'Simple',
                      Icons.arrow_forward,
                      paddingRight: 20,
                    ),
                    onDismissed: (_) => swapSimpleAdvancedCalculatorDisplay(),
                    child: Padding(
                      padding: EdgeInsets.only(left: horizontalPadding),
                      child: advancedCalculator,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
