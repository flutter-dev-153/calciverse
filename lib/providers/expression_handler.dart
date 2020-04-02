import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';


class Invalid {
  static const Infinity = 'Infinity';
  static const Zero = '0';
  static const InvalidExpression = 'Invalid Expression';
}

class ExpressionHandler with ChangeNotifier {
  static const clearInputWhenItIs = [
    Invalid.Infinity,
    Invalid.Zero,
    Invalid.InvalidExpression,
  ];

  final Parser _parser = Parser();
  var _equationInput = '';
  Function _addToHistoryHandler;
  final ContextModel _contextModel = ContextModel();

  ExpressionHandler() {
    _contextModel.bindVariable(Variable("è"), Number(math.e));
    _contextModel.bindVariable(Variable("pi"), Number(math.pi));
    _contextModel.bindFunction(Log(Number(10), Variable('x')));
  }

  String get equationInput {
    return _equationInput.substring(0);
  }

  void setAddToHistoryHandler(Function handler) {
    _addToHistoryHandler = handler;
  }

  void addToHistory(String query, String result) {
    _addToHistoryHandler('$query = $result');
  }

  void _clear() {
    _equationInput = '';
    notifyListeners();
  }

  void _sanityCleanUp() {
    if (clearInputWhenItIs.contains(_equationInput)) {
      _equationInput = '';
    }
  }

  void _insert(String character) {
    _sanityCleanUp();

    _equationInput += character;
    notifyListeners();
  }

  double _bound(double n) {
    // Accuracy starts to degrade as around 2^63 is the
    // highest number, double can store accurately.
    return n > math.pow(10, 16) ? double.infinity : n;
  }

  void _evaluate() {
    var query = _equationInput;
    var historyResult = Invalid.InvalidExpression;
    try {
      final expression = _parser.parse(_equationInput);
      final result = _bound(expression.evaluate(
        EvaluationType.REAL,
        _contextModel,
      ) as double);
      final processedResult =
          result % 1 == 0 ? result.toInt() : result.toStringAsFixed(8);
      historyResult =
          (result % 1 == 0 ? result.toInt() : result.toStringAsFixed(2))
              .toString();
      _equationInput = '$processedResult';
    } catch (error) {
      _equationInput = Invalid.InvalidExpression;
    } finally {
      addToHistory(query, '$historyResult');
      notifyListeners();
    }
  }

  void processInput(String character) {
    switch (character) {
      case 'AC':
        _clear();
        break;
      case '=':
        _evaluate();
        break;
      case 'x':
        _insert('*');
        break;
      case 'x!':
        _insert('fact(');
        break;
      case 'x^y':
        _insert('^');
        break;
      case 'è^x':
        _insert('è^');
        break;
      case '10^x':
        _insert('10^');
        break;
      case 'log(b, x)':
        _insert('log(');
        break;
      case 'ln':
        _insert('ln(');
        break;
      default:
        _insert(character);
        break;
    }
  }
}
