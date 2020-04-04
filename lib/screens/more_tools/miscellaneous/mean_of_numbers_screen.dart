import 'dart:math';

import 'package:flutter/material.dart';

import './miscellaneous_screen.dart';

class MeanOfNumbersScreen extends StatefulWidget {
  static const routeName =
      MiscellaneousScreen.routeName + '/mean-of-numbers';

  @override
  _MeanOfNumbersScreenState createState() =>
      _MeanOfNumbersScreenState();
}

class _MeanOfNumbersScreenState extends State<MeanOfNumbersScreen> {
  var inputController = TextEditingController();
  double result;

  Widget getInputBox(TextEditingController textEditingController) {
    final themeData = Theme.of(context);

    return Container(
      width: 180,
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

  Row getInputRow(String data, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        styledText(data),
        styledText('='),
        getInputBox(controller),
      ],
    );
  }

  Text styledText(String data) {
    return Text(
      data,
      style: TextStyle(fontSize: 20),
    );
  }

  void clearFields() {
    setState(() {
      inputController.text = "";
      result = null;
    });
  }

  void showErrorSnackBar(BuildContext ctx,
      {String message = 'Invalid value!'}) {
    Scaffold.of(ctx).hideCurrentSnackBar();
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).errorColor),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 1),
    ));
  }

  double mean(List<double> list) {
    double sum = 0;
    for (int i = 0; i < list.length; i++) {
      sum += list[i];
    }
    return sum / list.length;
  }

  void check(BuildContext ctx) {
    setState(() {
      result = null;
    });

    if (inputController.text.isEmpty) {
      showErrorSnackBar(ctx);
      return;
    }

    // To close the keyboard
    FocusScope.of(context).unfocus();

    final split = inputController.text.split(',');
    var isValid = true;
    split.forEach((item) {
      if (item.isEmpty) return;
      final parsed = double.tryParse(item);
      if (parsed == null) {
        isValid = false;
      }
    });

    if (isValid == false) {
      showErrorSnackBar(ctx);
      return;
    }

    final list = <double>[];
    split.forEach((item) {
      if (item.isEmpty) return;
      list.add(double.parse(item));
    });

    setState(() {
      result = mean(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mean of numbers'),
        ),
        body: Builder(
          builder: (ctx) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 310,
                      height: 190,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              const Text(
                                'Input',
                                style: TextStyle(fontSize: 28),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              getInputRow('List<N>', inputController),
                              Container(
                                width: double.infinity,
                                child: const Text(
                                  'comma separated numbers',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MaterialButton(
                                    height: 35,
                                    minWidth: 70,
                                    elevation: 5,
                                    child: Text(
                                      'CLEAR',
                                      style: TextStyle(
                                          color: themeData.accentColor),
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
                                    onPressed: () => check(ctx),
                                    color: themeData.primaryColor,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      height: 120,
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Result',
                              style: TextStyle(fontSize: 28),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              result == null
                                  ? ''
                                  : 'Mean of [${inputController.text}] is ${result.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
