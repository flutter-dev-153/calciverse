import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/expression_handler.dart';
import './providers/history.dart';
import './screens/home_screen.dart';
import './screens/more_tools/linear_equations/linear_equations_screen.dart';
import './screens/more_tools/linear_equations/2_by_2_linear_equations_solver_screen.dart';
import './screens/more_tools/linear_equations/3_by_3_linear_equations_solver_screen.dart';
import './screens/more_tools/quadratic_equations_screen.dart';
import './screens/more_tools/matrix_operations/matrix_operations_screen.dart';
import './screens/more_tools/matrix_operations/inverse_of_a_matrix_screen.dart';
import './screens/more_tools/matrix_operations/co_factors_of_matrix_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const title = 'Calciverse';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => History(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ExpressionHandler(),
        ),
      ],
      child: MaterialApp(
        title: title,
        theme: ThemeData(
            primaryColor: Color.fromRGBO(10, 25, 47, 1),
            accentColor: Color.fromRGBO(107, 253, 218, 1),
            errorColor: Colors.redAccent),
        home: HomeScreen(
          appTitle: title,
        ),
        routes: {
          LinearEquationsScreen.routeName: (ctx) => LinearEquationsScreen(),
          QuadraticEquationsScreen.routeName: (ctx) =>
              QuadraticEquationsScreen(),
          TwoByTwoLinearEquationsSolverScreen.routeName: (ctx) =>
              TwoByTwoLinearEquationsSolverScreen(),
          ThreeByThreeLinearEquationsSolverScreen.routeName: (ctx) =>
              ThreeByThreeLinearEquationsSolverScreen(),
          MatrixOperationsScreen.routeName: (ctx) => MatrixOperationsScreen(),
          InverseOfAMatrixScreen.routeName: (ctx) => InverseOfAMatrixScreen(),
          CoFactorsOfAMatrixScreen.routeName: (ctx) =>
              CoFactorsOfAMatrixScreen(),
        },
      ),
    );
  }
}
