import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/display/calculations_display.dart';
import '../widgets/simple_calculator.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MediaQueryData _mediaQuery;
  double _totalHeight;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      _mediaQuery = MediaQuery.of(context);
      _totalHeight = _mediaQuery.size.height - _mediaQuery.padding.top;
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = _totalHeight * 0.1;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: CustomAppBar(title: widget.title, height: appBarHeight),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: _totalHeight * 0.01,
        ),
        child: Container(
          height: _totalHeight * 0.9,
          child: Column(
            children: <Widget>[
              CalculationsDisplay(_totalHeight * 0.40),
              SizedBox(height: _totalHeight * 0.02),
              SimpleCalculator(_totalHeight * 0.46),
            ],
          ),
        ),
      ),
    );
  }
}
