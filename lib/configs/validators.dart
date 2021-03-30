
import 'package:flutter/material.dart';

class Validator {

  static String ifRequired(bool isRequired, String value, FormFieldValidator<String> validator) =>
      isRequired ? (required(value) ?? validator(value)) : validator(value);

  static String required(String value) =>
      _valid(value != null && value.isNotEmpty, 'This field is required');

  static String email(String value) =>
      _valid(value.contains("@"), 'Incorrect email');

  static String password(String value) =>
      _valid(value.length > 3, 'Incorrect password');
  
  static String confirm_password(String pwd, String confirm) {
      return _valid(pwd == confirm, 'Not equal to password');

  }

  static String empty(String value) =>
      null;

  static String _valid(bool test, String message) =>
      test ? null : message;
}