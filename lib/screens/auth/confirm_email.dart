import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/mixins/input_decoration.dart';
import 'package:sapiency/mixins/box_decoration.dart';
import 'package:sapiency/configs/routes.dart';

class ConfirmEmailScreen extends StatelessWidget with SapiencyInputDecoration {
  String s1 = "", s2 = "", s3 = "", s4 = "";
  Image getHeaderImage() => Image.asset(
        "assets/images/newsletter-dev.png",
        width: 50,
        height: 50,
      );

  String getTitleText() {
    return "Confirm your email";
  }

  String getSubtitleText() {
    return "Please type the code provided in the comfirmation email..";
  }

  Widget getForm() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: standardInputDecoration(),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 20),
                  minLines: 1,
                  maxLines: 1,
                  onSaved: (value) => () {
                    s1 = value;
                  },
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: standardInputDecoration(),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 20),
                  minLines: 1,
                  maxLines: 1,
                  onSaved: (value) => () {
                    s2 = value;
                  },
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: standardInputDecoration(),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 20),
                  minLines: 1,
                  maxLines: 1,
                  onSaved: (value) => () {
                    s3 = value;
                  },
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: standardInputDecoration(),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 20),
                  minLines: 1,
                  maxLines: 1,
                  onSaved: (value) => () {
                    s4 = value;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
                  Container(child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getHeaderImage(),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Text(
                                getTitleText(),
                                style: __theme.textTheme.headline1,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                getSubtitleText(),
                                style: __theme.textTheme.subtitle1,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 40,
                      ),
                      getForm(),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: SapiencyTheme.primaryColor,
                          child: Text("Continue"),
                          onPressed: () {
                            // Provider.of<AuthProvider>(ctx, listen: false).signupByEmail(email: data['email'], password: data['password'], nickname: data['nickname'],);
                            Navigator.of(context)
                                .pushNamed(Routes.INPUT_PHONE_ROUTE);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "You don't recieve the code yet?",
                            style: __theme.textTheme.subtitle1,
                          ),
                          RaisedButton(
                            textColor: SapiencyTheme.primaryColor,
                            color: Colors.white,
                            child: Text("Resend"),
                            onPressed: () {
                              // Provider.of<AuthProvider>(ctx, listen: false).signupByEmail(email: data['email'], password: data['password'], nickname: data['nickname'],);
                              // Navigator.of(context).pushNamed(Routes.CONFIRM_EMAIL);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: __deviceSize.height - 250,),
                        // Expanded(child: Container()),
                        Container(
                          height: 70,
                          decoration: standardBoxTipDecoration(),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 20.0),
                                    child: Image.asset(
                                      "assets/images/bulb.png",
                                      width: 50,
                                      height: 50,
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 9,
                                child: Text(
                                  "In order to proceed, you need to confirm your email address",
                                  style: __theme.textTheme.subtitle1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ));
  }

  Widget _sectionTitle(String text) => Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(text),
      );
}
