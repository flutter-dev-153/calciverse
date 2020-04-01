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

  ContextModel _getContextModel() {
    final contextModel = ContextModel();
    return contextModel;
  }

  void _evaluate() {
    var query = _equationInput;
    try {
      final expression = _parser.parse(_equationInput);
      final result = expression.evaluate(
        EvaluationType.REAL,
        _getContextModel(),
      ) as double;
      final processedResult =
          result % 1 == 0 ? result.toInt() : result.toStringAsFixed(2);
      _equationInput = '$processedResult';
    } catch (error) {
      _equationInput = Invalid.InvalidExpression;
    } finally {
      addToHistory(query, _equationInput);
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
      default:
        _insert(character);
        break;
    }
  }
}
