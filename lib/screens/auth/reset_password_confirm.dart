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
import 'package:sapiency/widgets/forms/password_confirm_form_field.dart';

class ResetPasswordConfirmScreen extends SignUpScreenTheme {
  @override
  getHeaderImage() => Image.asset(
        "assets/images/invert-process.png",
        width: 50,
        height: 50,
      );

  @override
  String getTitleText() => 'Reset password';

  @override
  String getSubtitleText() =>
      'Please set a new password and confirm it by putting the same password below.';

  @override
  Widget getForm() => BaseForm(
        submitText: 'Reset my password',
        fields: {
          'password': PasswordConfirmFormField(showForgotPassword: false),
        },
        onSubmit: (data, ctx) async {
          print("data ==  ${data["password"]}");
          await _showMyDialog(ctx);
          Navigator.of(ctx).pushNamed(Routes.WELCOME_ROUTE);
        },
        onSubmitError: (error) {
          print(error);
        },
      );

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Success to set the new password'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Go to welcome'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
