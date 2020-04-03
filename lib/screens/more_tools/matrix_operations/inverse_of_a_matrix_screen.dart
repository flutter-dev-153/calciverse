import 'package:linalg/linalg.dart';
import 'package:flutter/material.dart';

class InverseOfAMatrixScreen extends StatefulWidget {
  static const routeName = '/matrix-inverse';

  @override
  _InverseOfAMatrixScreenState createState() => _InverseOfAMatrixScreenState();
}

class _InverseOfAMatrixScreenState extends State<InverseOfAMatrixScreen> {
  List<List<TextEditingController>> twoByTwoMatrix;
  List<List<TextEditingController>> threeByThreeMatrix;
  Map<String, List<List<TextEditingController>>> valuesMapping;
  var chosen = '2 x 2';
  List<List<double>> result = [];
  var isSolvable = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((_) {
      setState(() {
        twoByTwoMatrix = [
          [TextEditingController(), TextEditingController()],
          [TextEditingController(), TextEditingController()],
        ];
        threeByThreeMatrix = [
          [
            TextEditingController(),
            TextEditingController(),
            TextEditingController()
          ],
          [
            TextEditingController(),
            TextEditingController(),
            TextEditingController()
          ],
          [
            TextEditingController(),
            TextEditingController(),
            TextEditingController()
          ],
        ];
        valuesMapping = {'2 x 2': twoByTwoMatrix, '3 x 3': threeByThreeMatrix};
      });
    });
  }

  DropdownButton getDropDownButton() {
    final themeData = Theme.of(context);

    return DropdownButton<String>(
      value: chosen,
      style: TextStyle(color: themeData.primaryColor, fontSize: 15),
      underline: Container(
        height: 2,
        color: themeData.accentColor,
      ),
      onChanged: (newValue) {
        setState(() {
          chosen = newValue;
        });
      },
      items: ['2 x 2', '3 x 3']
          .map((item) => DropdownMenuItem(
                value: item,
                child: Center(child: Text(item)),
              ))
          .toList(),
    );
  }

  Widget getMatrix() {
    if (valuesMapping == null) {
      return null;
    }

    final matrix = valuesMapping[chosen];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: matrix
          .map((row) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: row
                    .map(
                      (controller) => Container(
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Theme.of(context).primaryColor),
                        ),
                        child: TextField(
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          controller: controller,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                      ),
                    )
                    .toList(),
              ))
          .toList(),
    );
  }

  bool areInputsValid() {
    final matrix = valuesMapping[chosen];
    var inputsValid = true;

    matrix.forEach((row) => row.forEach((controller) {
          if (controller.text.isEmpty ||
              double.tryParse(controller.text) == null) {
            inputsValid = false;
          }
        }));

    return inputsValid;
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

    var chosenMatrix = valuesMapping[chosen];
    var matrix = Matrix(
      chosenMatrix
          .map(
            (row) => row
                .map(
                  (controller) => double.parse(controller.text),
                )
                .toList(),
          )
          .toList(),
    );

    if (matrix.det() == 0) {
      setState(() {
        isSolvable = false;
        result = null;
      });
      return;
    }

    var matrixResult = matrix.inverse();
    setState(() {
      isSolvable = true;
      result = [
        [matrixResult[0][0], matrixResult[0][1]],
        [matrixResult[1][0], matrixResult[1][1]],
      ];
      if (matrixResult.n == 3) {
        result[0].add(matrixResult[0][2]);
        result[1].add(matrixResult[1][2]);
        result
            .add([matrixResult[2][0], matrixResult[2][1], matrixResult[2][2]]);
      }
    });
  }

  void clearFields() {
    setState(() {
      result = [];
      isSolvable = true;
      final matrix = valuesMapping[chosen];
      matrix.forEach((row) => row.forEach((controller) {
            controller.text = '';
          }));
    });
  }

  Widget getOutputBox(double data) {
    final themeData = Theme.of(context);
    final output = data.toStringAsFixed(2);

    return Container(
      width: 70,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: themeData.primaryColor),
      ),
      child: Center(
        child: Text('$output', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget getResult() {
    if (valuesMapping == null) {
      return null;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Result',
              style: const TextStyle(fontSize: 20),
            ),
            if (result != null)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: result
                      .map(
                        (List<double> row) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: row
                              .map(
                                (item) => getOutputBox(item),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Matrix Inverse')),
        body: SingleChildScrollView(
          child: Builder(
            builder: (ctx) => Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                width: 300,
                child: Column(
                  children: <Widget>[
                    getDropDownButton(),
                    SizedBox(
                      height: 140,
                      child: Card(
                        child: getMatrix(),
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
                          child: Text(
                            'Find Inverse',
                            style: TextStyle(color: themeData.accentColor),
                          ),
                          onPressed: () => calculate(ctx),
                          color: themeData.primaryColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: getResult(),
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
