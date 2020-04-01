import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double height;
  final double width;
  final String content;
  final Function onPressed;
  final Color backgroundColor;
  final Color textColor;

  Button({
    @required this.height,
    @required this.width,
    @required this.content,
    @required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      height: height,
      width: width,
      child: InkWell(
        onTap: () {},
        child: FlatButton(
          splashColor: themeData.accentColor,
          onPressed: () => onPressed(content),
          color: backgroundColor != null
              ? backgroundColor
              : const Color.fromRGBO(240, 240, 240, 1),
          child: Text(
            content,
            style: TextStyle(
              fontSize: height / 2.4,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
