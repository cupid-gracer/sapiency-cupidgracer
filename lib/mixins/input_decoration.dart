import 'package:flutter/material.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/images.dart';
import 'package:sapiency/screens/home/mainhome.dart';

mixin SapiencyInputDecoration {
  InputDecoration standardInputDecoration(
          {String placeholder = "", Widget suffix, Function onPressedSuffix}) =>
      InputDecoration(
        hintText: placeholder,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        enabledBorder: border(color: SapiencyTheme.borderColor, width: 2),
        focusedBorder: border(color: SapiencyTheme.primaryColor),
        errorBorder: border(color: SapiencyTheme.errorColor),
        focusedErrorBorder: border(color: SapiencyTheme.errorColor, width: 2),
        suffixIcon: suffix !=null?
            IconButton(
                iconSize: 30,
                padding: EdgeInsets.all(0),
                color: Colors.white,
                icon: suffix,
                onPressed: ()=>onPressedSuffix):null,
        // suffixIcon: suffix
      );

  OutlineInputBorder border({Color color, double width = 1}) =>
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: color, width: width));

  InputDecoration standardConfirmInputDecoration(
          {String placeholder = "", Widget suffix}) =>
      InputDecoration(
        hintText: placeholder,
        contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        enabledBorder: border(color: SapiencyTheme.borderColor, width: 2),
        focusedBorder: border(color: SapiencyTheme.primaryColor),
        errorBorder: border(color: SapiencyTheme.errorColor),
        focusedErrorBorder: border(color: SapiencyTheme.errorColor, width: 2),
        suffix: suffix,
      );
}
