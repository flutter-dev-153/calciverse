import 'package:calciverse/providers/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './simple_button.dart';
import '../providers/expression_handler.dart';

class AdvancedCalculator extends StatefulWidget {
  final double height;

  AdvancedCalculator(this.height);

  @override
  _AdvancedCalculatorState createState() => _AdvancedCalculatorState();
}

class _AdvancedCalculatorState extends State<AdvancedCalculator> {
  var inverseMode = false;
  final content = [
    [
      {'value': "(", 'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)},
      {'value': ")", 'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)},
      {'value': "AC", 'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)}
    ],
    [
      {'value': "Inv"},
      {'value': "sin", 'inverse': 'arcsin'},
      {'value': "ln", 'inverse': 'è^x'}
    ],
    [
      {'value': "pi"},
      {'value': "cos", 'inverse': 'arccos'},
      {'value': "log(b, x)", 'inverse': '10^x'}
    ],
    [
      {'value': "è"},
      {'value': "tan", 'inverse': 'arctan'},
      {'value': "x^y"}
    ],
  ];

  void _onButtonPress(String value) {
    if (value == 'Inv') {
      setState(() {
        inverseMode = !inverseMode;
      });
      return;
    }
    Provider.of<ExpressionHandler>(context, listen: false).processInput(value);
  }

  Widget buildRightSlideHintBar(
    BuildContext context,
    double rightSliderWidth,
    double rightSliderHeight,
  ) {
    final themeData = Theme.of(context);

    return Container(
      width: rightSliderWidth,
      height: rightSliderHeight,
      color: themeData.primaryColor,
      child: Center(
        child: Icon(
          Icons.chevron_right,
          color: themeData.accentColor,
        ),
      ),
    );
  }

  Widget buildButtonLayout(
    BuildContext context,
    double keypadWidth,
    double keypadHeight,
  ) {
    final buttonHeight = keypadHeight / 4.3;
    final buttonWidth = (keypadWidth - 10) / 3.3;

    return Container(
      width: keypadWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: content
            .map(
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row
                    .map(
                      (Map<String, Object> item) => SimpleButton(
                        height: buttonHeight,
                        width: buttonWidth,
                        content: inverseMode && item.containsKey('inverse')
                            ? item['inverse']
                            : item['value'],
                        onPressed: _onButtonPress,
                        backgroundColor: item.containsKey('backgroundColor')
                            ? (item['backgroundColor'] as Color)
                            : null,
                        textColor: item.containsKey('textColor')
                            ? (item['textColor'] as Color)
                            : Theme.of(context).primaryColor,
                        textSize: buttonHeight / 3.5,
                        specialButton: item.containsKey('special'),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableWidth = MediaQuery.of(context).size.width;

    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildButtonLayout(
              context,
              availableWidth * 0.92,
              widget.height,
            ),
            buildRightSlideHintBar(
              context,
              availableWidth * 0.06,
              widget.height,
            ),
          ]),
    );
  }
}
