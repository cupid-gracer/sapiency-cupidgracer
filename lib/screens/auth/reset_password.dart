import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/forms/base_form.dart';
import 'package:sapiency/models/oauth.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/configs/validators.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/themes/sign_up_theme.dart';
import 'package:sapiency/widgets/buttons/standard.dart';
import 'package:sapiency/widgets/buttons/submit.dart';
import 'package:sapiency/widgets/forms/input_form_field.dart';
import 'package:sapiency/widgets/forms/password_form_field.dart';

class ResetPasswordScreen extends SignUpScreenTheme {

  @override
  getHeaderImage() => Image.asset(
    "assets/images/invert-process.png",
    width: 50,
    height: 50,
  );

  @override
  String getTitleText() => 'Reset password';

  @override
  String getSubtitleText() => 'Put the email address you used while signup';

  @override
  Widget getForm() => BaseForm(
    submitText: 'Continue',
    fields: {
      'email': InputFormField(
          label: 'Email address',
          placeholder: 'johndoe@example.com',
          keyboardType: TextInputType.emailAddress,
          validator: Validator.email
      )
    },
    onSubmit: (data, ctx) {
      Navigator.of(ctx).pushNamed(Routes.RESET_PASSWORD_CONFIRM_ROUTE);
    },
    onSubmitError: (error) {
      print(error);
    },
  );

}


