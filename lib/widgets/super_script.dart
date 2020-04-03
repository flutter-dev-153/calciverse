import 'package:flutter/material.dart';

class SuperScript extends StatelessWidget {
  const SuperScript({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          child,
          Positioned(
            left: 10,
            top: 0,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
              ),
            )
          )
        ],
      ),
    );
  }
}
