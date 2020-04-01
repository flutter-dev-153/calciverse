import 'package:flutter/material.dart';

import './current_input.dart';
import './history_list_display.dart';

class CalculationsDisplay extends StatelessWidget {
  final double height;

  CalculationsDisplay(this.height);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: height * 0.01, color: themeData.primaryColor),
      ),
      child: Column(
        children: <Widget>[
          HistoryListDisplay(height),
          CurrentInput(height),
        ],
      ),
    );
  }
}
