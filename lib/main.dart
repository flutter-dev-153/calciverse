import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/expression_handler.dart';
import './providers/history.dart';
import './screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        title: 'Calciverse',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(10, 25, 47, 1),
          accentColor: Color.fromRGBO(107, 253, 218, 1),
        ),
        home: HomeScreen(title: 'Calciverse'),
        routes: {},
      ),
    );
  }
}
