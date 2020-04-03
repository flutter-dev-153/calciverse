import 'package:flutter/material.dart';
import 'package:extended_math/extended_math.dart';

import '../../widgets/super_script.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/custom_app_bar.dart';

class QuadraticEquationsScreen extends StatefulWidget {
  static const routeName = '/quadratic-equations';

  @override
  _QuadraticEquationsScreenState createState() =>
      _QuadraticEquationsScreenState();
}

// EQUATION OF FORM: ax^2 + bx + c = 0

class _QuadraticEquationsScreenState extends State<QuadraticEquationsScreen> {
  var aController = TextEditingController();
  var bController = TextEditingController();
  var cController = TextEditingController();

  // 3rd argument to check if solutions exist or not
  final List<Complex> resultValues = [null, null];

  void clearFields() {
    setState(() {
      aController.text = "";
      bController.text = "";
      cController.text = "";
      resultValues[0] = null;
      resultValues[1] = null;
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
    TextEditingController a,
    TextEditingController b,
    TextEditingController c,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getInputBox(a),
        SuperScript(
          child: styledText('x'),
          value: '2',
        ),
        styledText('+'),
        getInputBox(b),
        styledText('x'),
        styledText('+'),
        getInputBox(c),
        styledText('='),
        styledText('0'),
      ],
    );
  }

  bool areInputsValid() {
    if (aController.text.isEmpty || double.tryParse(aController.text) == null) {
      return false;
    }

    if (bController.text.isEmpty || double.tryParse(bController.text) == null) {
      return false;
    }

    if (cController.text.isEmpty || double.tryParse(cController.text) == null) {
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

    final a = double.parse(aController.text);
    final b = double.parse(bController.text);
    final c = double.parse(cController.text);

    var result = QuadraticEquation(a: a, b: b, c: c).calculate();

    setState(() {
      resultValues[0] = result['x1'];
      resultValues[1] = result['x2'];
    });
  }

  String complexToString(Complex number) {
    if (number.im == 0) {
      return '${number.re.toStringAsFixed(3)}';
    }
    return '${number.re.toStringAsFixed(3)} + i(${number.im.toStringAsFixed(3)})';
  }

  Widget getOutputBox(int index) {
    final themeData = Theme.of(context);

    final output =
        resultValues[index] == null ? '' : complexToString(resultValues[index]);

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
        styledText(index == 0 ? 'x1' : 'x2'),
        styledText('='),
        getOutputBox(index),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final mediaQuery = MediaQuery.of(context);
    final viewHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final appBarHeight = viewHeight * 0.1;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Quadratic Equations',
          height: appBarHeight,
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Builder(
            builder: (ctx) => Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        height: 150,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  getInputRow(
                                      aController, bController, cController),
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
                        height: 120,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  getOutputRow(0),
                                  getOutputRow(1),
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
      ),
    );
    ;
  }
}
