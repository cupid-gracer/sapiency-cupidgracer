import 'package:flutter/material.dart';
import 'package:sapiency/configs/theme.dart';

mixin SapiencyInputDecoration {

  InputDecoration standardInputDecoration({String placeholder = "", Widget suffix}) =>
      InputDecoration(
        hintText: placeholder,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15
        ),
        enabledBorder: border(color: SapiencyTheme.borderColor, width: 2),
        focusedBorder: border(color: SapiencyTheme.primaryColor),
        errorBorder: border(color: SapiencyTheme.errorColor),
        focusedErrorBorder: border(color: SapiencyTheme.errorColor, width: 2),
        suffix: suffix,
      );

  OutlineInputBorder border({Color color, double width = 1}) =>
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              color: color,
              width: width
          )
      );
}