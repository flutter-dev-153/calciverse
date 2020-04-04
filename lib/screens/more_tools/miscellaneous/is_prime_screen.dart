import 'package:flutter/material.dart';

import './miscellaneous_screen.dart';

class IsPrimeScreen extends StatefulWidget {
  static const routeName = MiscellaneousScreen.routeName + '/is-prime';

  @override
  _IsPrimeScreenState createState() => _IsPrimeScreenState();
}

class _IsPrimeScreenState extends State<IsPrimeScreen> {
  var inputController = TextEditingController();
  bool result;

  Widget getInputBox(TextEditingController textEditingController) {
    final themeData = Theme.of(context);

    return Container(
      width: 200,
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

  bool isPrime(int n) {
    if (n <= 3) {
      return true;
    }

    if (n % 2 == 0 || n % 3 == 0) {
      return false;
    }

    int i = 5;
    while (i * i <= n) {
      if (n % i == 0 || n % (i + 2) == 0) {
        return false;
      }
      i += 6;
    }
    return true;
  }

  void check(BuildContext ctx) {
    if (inputController.text.isEmpty) {
      showErrorSnackBar(ctx);
      return;
    }

    final parsedNumber = int.tryParse(inputController.text);
    if (parsedNumber == null || parsedNumber <= 1) {
      showErrorSnackBar(ctx);
      return;
    }

    // To close the keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      result = isPrime(parsedNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Is Prime?'),
        ),
        body: Builder(
          builder: (ctx) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 300,
                      height: 180,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                'Input',
                                style: TextStyle(fontSize: 28),
                                textAlign: TextAlign.center,
                              ),
                              getInputRow('N', inputController),
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
                                  : '${inputController.text} is ' +
                                      (result ? 'PRIME' : 'NOT PRIME'),
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
