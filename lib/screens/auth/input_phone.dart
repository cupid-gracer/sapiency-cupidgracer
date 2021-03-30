import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget getForm() => BaseForm(
        submitText: 'Continue',
        fields: {
          'phone': PhoneFormField(
            label: 'Your Phone number',
            placeholder: '123-456-789',
            keyboardType: TextInputType.phone,
          ),
        },
        onSubmit: (data, ctx) {
          print("phone=====    ${data["phone"]}");
          Navigator.pushNamed(ctx, Routes.CONFIRM_PHONE, arguments: {'phone_number': data["phone"],});
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
                  // Container(
                  //   child: Column(
                  //     children: [
                  //       SizedBox(height: __deviceSize.height - 250,),
                  //       // Expanded(child: Container()),
                  //       Container(
                  //         height: 70,
                  //         decoration: standardBoxTipDecoration(),
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //                 flex: 1,
                  //                 child: Container(
                  //                   margin: EdgeInsets.only(bottom: 20.0),
                  //                   child: Image.asset(
                  //                     "assets/images/bulb.png",
                  //                     width: 50,
                  //                     height: 50,
                  //                   ),
                  //                 )),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
                  //             Expanded(
                  //               flex: 9,
                  //               child: Text(
                  //                 "In order to proceed, you need to confirm your email address",
                  //                 style: __theme.textTheme.subtitle1,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              )),
        ));
  }

  Widget _sectionTitle(String text) => Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(text),
      );
}
