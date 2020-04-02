import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final double height;
  final double width;
  final String content;
  final IconData iconData;
  final Function onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double textSize;
  final bool specialButton;

  SimpleButton({
    @required this.height,
    @required this.width,
    @required this.content,
    @required this.onPressed,
    this.iconData,
    this.backgroundColor,
    this.textColor,
    this.textSize,
    this.specialButton = false,
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
          color: specialButton
              ? themeData.primaryColor
              : (backgroundColor != null
                  ? backgroundColor
                  : const Color.fromRGBO(240, 240, 240, 1)),
          child: iconData != null
              ? Icon(iconData)
              : Text(
                  content,
                  style: TextStyle(
                    fontSize: textSize != null ? textSize : height / 2.4,
                    color: specialButton ? themeData.accentColor : textColor,
                  ),
                ),
        ),
      ),
    );
  }
}
