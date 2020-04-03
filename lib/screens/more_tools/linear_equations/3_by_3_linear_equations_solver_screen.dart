import 'package:calciverse/helpers/linear_equations_handler.dart';
import 'package:flutter/material.dart';

import './linear_equations_screen.dart';

class ThreeByThreeLinearEquationsSolverScreen extends StatefulWidget {
  static const routeName = LinearEquationsScreen.routeName + '/3-by-3';

  @override
  _ThreeByThreeLinearEquationsSolverScreenState createState() =>
      _ThreeByThreeLinearEquationsSolverScreenState();
}

class _ThreeByThreeLinearEquationsSolverScreenState
    extends State<ThreeByThreeLinearEquationsSolverScreen> {
  var x1Controller = TextEditingController();
  var y1Controller = TextEditingController();
  var z1Controller = TextEditingController();
  var res1Controller = TextEditingController();
  var x2Controller = TextEditingController();
  var y2Controller = TextEditingController();
  var z2Controller = TextEditingController();
  var res2Controller = TextEditingController();
  var x3Controller = TextEditingController();
  var y3Controller = TextEditingController();
  var z3Controller = TextEditingController();
  var res3Controller = TextEditingController();

  // 4th argument to check if solutions exist or not
  final List<double> resultValues = [null, null, null, 1];

  bool areInputsValid() {
    if (x1Controller.text.isEmpty ||
        double.tryParse(x1Controller.text) == null) {
      return false;
    }

    if (y1Controller.text.isEmpty ||
        double.tryParse(y1Controller.text) == null) {
      return false;
    }

    if (z1Controller.text.isEmpty ||
        double.tryParse(z1Controller.text) == null) {
      return false;
    }

    if (res1Controller.text.isEmpty ||
        double.tryParse(res1Controller.text) == null) {
      return false;
    }

    if (x2Controller.text.isEmpty ||
        double.tryParse(x2Controller.text) == null) {
      return false;
    }

    if (y2Controller.text.isEmpty ||
        double.tryParse(y2Controller.text) == null) {
      return false;
    }

    if (z2Controller.text.isEmpty ||
        double.tryParse(z2Controller.text) == null) {
      return false;
    }

    if (res2Controller.text.isEmpty ||
        double.tryParse(res2Controller.text) == null) {
      return false;
    }

    if (x3Controller.text.isEmpty ||
        double.tryParse(x3Controller.text) == null) {
      return false;
    }

    if (y3Controller.text.isEmpty ||
        double.tryParse(y3Controller.text) == null) {
      return false;
    }

    if (z3Controller.text.isEmpty ||
        double.tryParse(z3Controller.text) == null) {
      return false;
    }

    if (res3Controller.text.isEmpty ||
        double.tryParse(res3Controller.text) == null) {
      return false;
    }

    return true;
  }

  void showErrorSnackBar(BuildContext ctx) {
    Scaffold.of(ctx).hideCurrentSnackBar();
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text(
        'Invalid values!',
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).errorColor),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 1),
    ));
  }

  void calculate(BuildContext ctx) {
    if (areInputsValid() == false) {
      showErrorSnackBar(ctx);
      return;
    }

    // To close the keyboard
    FocusScope.of(context).unfocus();

    var result = LinearEquationsHandler.solveEquationsInThreeVariables(
      x1: double.parse(x1Controller.text),
      y1: double.parse(y1Controller.text),
      z1: double.parse(z1Controller.text),
      res1: double.parse(res1Controller.text),
      x2: double.parse(x2Controller.text),
      y2: double.parse(y2Controller.text),
      z2: double.parse(z2Controller.text),
      res2: double.parse(res2Controller.text),
      x3: double.parse(x3Controller.text),
      y3: double.parse(y3Controller.text),
      z3: double.parse(z3Controller.text),
      res3: double.parse(res3Controller.text),
    );

    setState(() {
      resultValues[0] = result[0];
      resultValues[1] = result[1];
      resultValues[2] = result[2];
    });
  }

  void clearFields() {
    setState(() {
      x1Controller.text = "";
      y1Controller.text = "";
      z1Controller.text = "";
      res1Controller.text = "";

      x2Controller.text = "";
      y2Controller.text = "";
      z2Controller.text = "";
      res2Controller.text = "";

      x3Controller.text = "";
      y3Controller.text = "";
      z3Controller.text = "";
      res3Controller.text = "";

      resultValues[0] = 0;
      resultValues[1] = 0;
      resultValues[2] = 0;
    });
  }

  Text styledText(String data) {
    return Text(
      data,
      style: TextStyle(fontSize: 20),
    );
  }

  Widget getInputBox(TextEditingController textEditingController) {
    final themeData = Theme.of(context);

    return Container(
      width: 70,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: themeData.primaryColor),
      ),
      child: TextField(
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        controller: textEditingController,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }

  Row getInputRow(
    TextEditingController x,
    TextEditingController y,
    TextEditingController z,
    TextEditingController res,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getInputBox(x),
        styledText('x'),
        styledText('+'),
        getInputBox(y),
        styledText('y'),
        styledText('+'),
        getInputBox(z),
        styledText('z'),
        styledText('='),
        getInputBox(res),
      ],
    );
  }

  Widget getOutputBox(int index) {
    final themeData = Theme.of(context);

    final output = resultValues[3] == 0
        ? 'No solutions.'
        : (resultValues[index] == null
            ? ''
            : ((resultValues[index] - resultValues[index].round() > -0.000001 &&
                    resultValues[index] - resultValues[index].round() <
                        0.000001)
                ? resultValues[index].round()
                : resultValues[index].toStringAsFixed(5)));

    return Container(
      width: 200,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: themeData.primaryColor),
      ),
      child: Center(
        child: Text('$output', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Row getOutputRow(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        styledText(index == 0 ? 'x' : (index == 1 ? 'y' : 'z')),
        styledText('='),
        getOutputBox(index),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('3-by-3 solver'),
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (ctx) => Container(
            width: double.infinity,
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: 210,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Enter the values',
                            style: TextStyle(
                              fontSize: 25,
                              color: themeData.primaryColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                getInputRow(
                                  x1Controller,
                                  y1Controller,
                                  z1Controller,
                                  res1Controller,
                                ),
                                getInputRow(
                                  x2Controller,
                                  y2Controller,
                                  z2Controller,
                                  res2Controller,
                                ),
                                getInputRow(
                                  x3Controller,
                                  y3Controller,
                                  z3Controller,
                                  res3Controller,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MaterialButton(
                                height: 35,
                                minWidth: 70,
                                elevation: 5,
                                child: Text(
                                  'CLEAR',
                                  style:
                                      TextStyle(color: themeData.accentColor),
                                ),
                                onPressed: clearFields,
                                color: themeData.primaryColor,
                              ),
                              MaterialButton(
                                height: 35,
                                minWidth: 70,
                                elevation: 5,
                                child: Icon(
                                  Icons.check,
                                  size: 22,
                                  color: themeData.accentColor,
                                ),
                                onPressed: () => calculate(ctx),
                                color: themeData.primaryColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Result',
                            style: TextStyle(
                              fontSize: 25,
                              color: themeData.primaryColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                getOutputRow(0),
                                getOutputRow(1),
                                getOutputRow(2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
