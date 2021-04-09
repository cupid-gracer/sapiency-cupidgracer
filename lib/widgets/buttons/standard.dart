import 'package:flutter/material.dart';
import 'package:sapiency/configs/theme.dart';

class StandardButton extends StatelessWidget {
  final Widget label;
  final double width;
  final Function onPressed;
  final EdgeInsetsGeometry padding;

  StandardButton({
    this.label,
    this.onPressed,
    this.width = double.infinity,
    this.padding = EdgeInsets.zero
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,
        child: RaisedButton(
          textColor: getTextColor(),
          color: getBackgroundColor(),
          child: label,
          onPressed: onPressed,
        )
      )
    );
  }

  Color getTextColor() => SapiencyTheme.primaryColor;
  Color getBackgroundColor() => Colors.white;
}
