import 'package:calciverse/providers/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './button.dart';
import '../providers/expression_handler.dart';

class SimpleCalculator extends StatefulWidget {
  final double height;

  SimpleCalculator(this.height);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  final content = [
    [
      {'value': "(", 'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)},
      {'value': ")", 'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)},
      {'value': "%", 'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)},
      {
        'value': "AC",
        'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)
      },
    ],
    [
      {'value': "7"},
      {'value': "8"},
      {'value': "9"},
      {'value': "/", 'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)},
    ],
    [
      {'value': "4"},
      {'value': "5"},
      {'value': "6"},
      {'value': "x", 'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)},
    ],
    [
      {'value': "1"},
      {'value': "2"},
      {'value': "3"},
      {'value': "-", 'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)},
    ],
    [
      {'value': "0"},
      {'value': "."},
      {
        'value': "=",
      },
      {'value': "+", 'backgroundColor': const Color.fromRGBO(200, 200, 200, 1)},
    ],
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        // Set some props for the equals button.
        // Doing it here because context is available here.
        content[4][2]['backgroundColor'] = Theme.of(context).primaryColor;
        content[4][2]['textColor'] = Theme.of(context).accentColor;

        // Set the add-to-history handler in expression handler
        Provider.of<ExpressionHandler>(context, listen: false)
            .setAddToHistoryHandler(
                Provider.of<History>(context, listen: false)
                    .addToHistory);
      });
    });
  }

  void _onButtonPress(String value) {
    Provider.of<ExpressionHandler>(context, listen: false).processInput(value);
  }

  Widget buildButtonLayout(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final buttonHeight = (widget.height) / 5.2;
    final buttonWidth = (mediaQuery.size.width - 10) / 4.3;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: content
          .map(
            (row) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: row
                  .map(
                    (Map<String, Object> item) => Button(
                      height: buttonHeight,
                      width: buttonWidth,
                      content: item['value'],
                      onPressed: _onButtonPress,
                      backgroundColor: item.containsKey('backgroundColor')
                          ? (item['backgroundColor'] as Color)
                          : null,
                      textColor: item.containsKey('textColor')
                          ? (item['textColor'] as Color)
                          : Theme.of(context).primaryColor,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(),
      child: buildButtonLayout(context),
    );
  }
}
