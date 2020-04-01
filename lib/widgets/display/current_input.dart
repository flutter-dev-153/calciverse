import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/expression_handler.dart';

class CurrentInput extends StatelessWidget {
  final double parentHeight;

  CurrentInput(this.parentHeight);

  @override
  Widget build(BuildContext context) {
    final inputText = Provider.of<ExpressionHandler>(context).equationInput;

    return Container(
      height: parentHeight * 0.2,
      child: Center(
        child: Text(
          inputText == "" ? '0' : inputText,
          style: TextStyle(fontSize: (parentHeight * 0.2) / 2),
        ),
      ),
    );
  }
}
