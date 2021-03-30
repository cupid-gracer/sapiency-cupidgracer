import 'package:flutter/material.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/widgets/buttons/standard.dart';

class SubmitButton extends StandardButton {

  SubmitButton({
    label,
    onPressed,
    width = double.infinity,
    padding = EdgeInsets.zero
  }): super(label: label, onPressed: onPressed, width: width, padding: padding);

  @override
  Color getBackgroundColor() => SapiencyTheme.primaryColor;

  @override
  Color getTextColor() => Colors.white;
}
