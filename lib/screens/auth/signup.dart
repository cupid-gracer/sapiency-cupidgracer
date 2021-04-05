import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/forms/base_form.dart';
import 'package:sapiency/models/oauth.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/configs/validators.dart';
import 'package:sapiency/configs/images.dart';
import 'package:sapiency/themes/sign_up_theme.dart';
import 'package:sapiency/widgets/buttons/standard.dart';
import 'package:sapiency/widgets/buttons/submit.dart';
import 'package:sapiency/widgets/forms/input_form_field.dart';
import 'package:sapiency/widgets/forms/password_form_field.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupScreen extends SignUpScreenTheme {
  @override
  String getTitleText() => 'Create a new account!';

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
          'nickname': InputFormField(
            name: 'nickname',
            label: 'Nickname',
            placeholder: 'johndoe',
            keyboardType: TextInputType.name,
          ),
          'password': PasswordFormField(labelText: 'Password')
        },
        onSubmit: (data, ctx) {
          showModalBottomSheet<void>(
            context: ctx,
            builder: (ctx) {
              return agreeModal(data, ctx);
            },
          );
        },
        onSubmitError: (error) {
          print(error);
        },
      );

  @override
  Map<String, Widget> getBottomSections(BuildContext context) => {
        'Or use your favorite platform': Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: OAuthServices.services
                  .map((it) => SizedBox(
                      width: 50,
                      height: 50,
                      child: RaisedButton(
                          padding: EdgeInsets.zero,
                          child: Image.asset(it.icon),
                          onPressed: () {})))
                  .toList(),
            )),
        'Already have an account?': FlatButton(
            minWidth: double.infinity,
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.LOGIN_ROUTE);
            },
            padding: EdgeInsets.zero,
            child: Text('Tap here to login'))
      };

  Widget agreeModal(data, BuildContext ctx) {
    final __theme = Theme.of(ctx);
    return Container(
        color: Color(0xFF737373),
        height: 400,
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0))),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.privacy,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sapiency terms of service and privacy policy",
                    style: __theme.textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please read and agree to the Terms of service and our Privacy Policy",
                    style: __theme.textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: 'Read our ',
                          style: __theme.textTheme.bodyText1,
                        ),
                        new TextSpan(
                          text: 'terms of service',
                          style:
                              new TextStyle(color: SapiencyTheme.primaryColor, fontWeight: FontWeight.bold),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: 'Read our ',
                          style: __theme.textTheme.bodyText1,
                        ),
                        new TextSpan(
                          text: 'privacy policy',
                          style:
                              new TextStyle(color: SapiencyTheme.primaryColor, fontWeight: FontWeight.bold),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: SapiencyTheme.primaryColor,
                      child: Text("I've read and agree"),
                      onPressed: () {
                        // Provider.of<AuthProvider>(ctx, listen: false).signupByEmail(email: data['email'], password: data['password'], nickname: data['nickname'],);
                        Navigator.of(ctx).popAndPushNamed(Routes.CONFIRM_EMAIL);
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
