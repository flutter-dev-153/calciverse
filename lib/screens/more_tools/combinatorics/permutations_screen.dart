import 'package:flutter/material.dart';

import './combinatorics_screen.dart';

class PermutationsScreen extends StatefulWidget {
  static const routeName = CombinatoricsScreen.routeName + '/permutations';

  @override
  _PermutationsScreenState createState() => _PermutationsScreenState();
}

class _PermutationsScreenState extends State<PermutationsScreen> {
  var nTextEditingController = TextEditingController();
  var rTextEditingController = TextEditingController();
  BigInt result;

  bool areInputsValid() {
    if (nTextEditingController.text.isEmpty ||
        int.tryParse(nTextEditingController.text) == null) {
      return false;
    }

    if (rTextEditingController.text.isEmpty ||
        int.tryParse(rTextEditingController.text) == null) {
      return false;
    }

    return true;
  }

  void showErrorSnackBar(BuildContext ctx,
      {String message = 'Invalid values!'}) {
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

  BigInt permutations(n, r) {
    var res = BigInt.from(1);
    int j = 1;
    for (int i = 1; i <= n; i ++) {
      res *= BigInt.from(i);
      if (j <= n - r) {
        res = BigInt.from(res / BigInt.from(j));
      }
      j++;
    }
    return res;
  }

  void calculate(BuildContext ctx) {
    if (areInputsValid() == false) {
      showErrorSnackBar(ctx);
      return;
    }

    final n = int.parse(nTextEditingController.text);
    final r = int.parse(rTextEditingController.text);

    if (r > n || r < 0) {
      showErrorSnackBar(ctx);
      return;
    }

    // To close the keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      result = permutations(n, r);
    });
  }

  void clearFields() {
    setState(() {
      nTextEditingController.text = "";
      rTextEditingController.text = "";
      result = null;
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

  Widget getOutputBox() {
    final themeData = Theme.of(context);
    final controller = TextEditingController();
    controller.text = result == null ? '' : result.toString();

    return Container(
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: themeData.primaryColor),
      ),
      child: TextField(
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
        controller: controller,
        enabled: false,
        minLines: 5,
        maxLines: 13,
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

  Row getOutputRow(String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        styledText(data),
        styledText('='),
        getOutputBox(),
      ],
    );
  }

  Widget getBody() {
    final themeData = Theme.of(context);

    return Builder(
      builder: (ctx) => Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Input',
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              getInputRow('N', nTextEditingController),
                              getInputRow('R', rTextEditingController),
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
                                style: TextStyle(color: themeData.accentColor),
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
                        ),
                      ],
                    ),
                  ),
                ),
                width: 300,
                height: 220,
              ),
              SizedBox(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Output',
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              getOutputRow('Answer'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                width: 300,
                height: result == null ? 200 : (result < BigInt.parse('1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000') ? 260 : 340),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Permutations'),
        ),
        body: SingleChildScrollView(child: getBody()),
      ),
    );
  }
}
