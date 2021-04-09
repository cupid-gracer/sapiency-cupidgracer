import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/mixins/input_decoration.dart';
import 'package:sapiency/mixins/box_decoration.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/forms/base_form.dart';
import 'package:sapiency/screens/auth/confirm_phone.dart';
import 'package:sapiency/widgets/forms/phone_form_field.dart';

class InputPhoneScreen extends StatelessWidget with SapiencyInputDecoration {
  Image getHeaderImage() => Image.asset(
        "assets/images/mobile-chat.png",
        width: 50,
        height: 50,
      );

  String getTitleText() {
    return "Type your phone number!";
  }

  String getSubtitleText() {
    return "Please verify your phone number";
  }

  Widget getForm() => BaseForm(
        submitText: 'Continue',
        fields: {
          'phone': PhoneFormField(
            label: 'Your Phone number',
            placeholder: '123-456-789',
            keyboardType: TextInputType.phone,
          ),
        },
        onSubmit: (data, ctx) async {
          Map<String, String> map = ModalRoute.of(ctx).settings.arguments;
          String email = map['email'];
          String nickname = map['nickname'];
          print("phone=====    ${data["phone"]}");
          bool f = await Provider.of<AuthProvider>(ctx,listen: false)
              .resendEmailOrPhone(
            context: ctx,
            type: "phone",
            value: data["phone"],
            nickname: nickname,
          );
          if(f)
          Navigator.pushNamed(ctx, Routes.CONFIRM_PHONE, arguments: {"email" : email, "nickname" : nickname , 'phone_number': data["phone"],});
          // Provider.of<AuthProvider>(ctx, listen: false).loginByEmail(email: data['email'], password: data['password']);
        },
        onSubmitError: (error) {
          print(error);
        },
      );

  @override
  Widget build(BuildContext context) {
    final __deviceSize = MediaQuery.of(context).size;
    final __theme = Theme.of(context);

    return Scaffold(
        backgroundColor: __theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
              width: __deviceSize.width - 60,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getHeaderImage(),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          getTitleText(),
                          style: __theme.textTheme.headline1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          getSubtitleText(),
                          style: __theme.textTheme.subtitle1,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        getForm(),
                        const SizedBox(
                          height: 40,
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  Widget _sectionTitle(String text) => Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(text),
      );
}
