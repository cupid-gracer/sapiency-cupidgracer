import 'dart:async';

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
import 'package:sapiency/widgets/forms/input_form_field.dart';
import 'package:sapiency/widgets/forms/password_form_field.dart';

class LoginScreen extends SignUpScreenTheme {
  @override
  String getTitleText() => 'Welcome back!';

  @override
  String getSubtitleText() => 'Lorem ipsum';

  @override
  Widget getForm() => BaseForm(
        submitText: 'Continue',
        fields: {
          'email': InputFormField(
              label: 'Email address',
              placeholder: 'johndoe@example.com',
              keyboardType: TextInputType.emailAddress,
              validator: Validator.email),
          'password':
              PasswordFormField(labelText: 'Password', showForgotPassword: true)
        },
        onSubmit: (data, ctx) async {
          bool f = await Provider.of<AuthProvider>(ctx, listen: false)
              .loginByEmail(email: data['email'], password: data['password']);
          if (f)
            Navigator.of(ctx).pushNamedAndRemoveUntil(
                Routes.MAIN_HOME_ROUTE, (route) => false);
        },
        onSubmitError: (error) {
          print(error);
        },
      );

  @override
  Map<String, Widget> getBottomSections(BuildContext context) => {
        // 'Or use your favorite platform': Padding(
        //     padding: const EdgeInsets.only(bottom: 20),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: OAuthServices.services
        //           .map((it) => SizedBox(
        //               width: 50,
        //               height: 50,
        //               child: RaisedButton(
        //                   padding: EdgeInsets.zero,
        //                   child: Image.asset(it.icon),
        //                   onPressed: () {})))
        //           .toList(),
        //     )),
        'Don\'t you have an account?': Padding(
            padding: EdgeInsets.only(top: 10),
            child: StandardButton(
              label: 'Create a new account',
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.SIGNUP_ROUTE);
              },
            ))
      };
}
