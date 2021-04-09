import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/mixins/input_decoration.dart';
import 'package:sapiency/mixins/box_decoration.dart';
import 'package:sapiency/configs/routes.dart';

class ConfirmEmailScreen extends StatefulWidget
{
  @override
  _confirmEmailScreenState createState() => _confirmEmailScreenState();
}

class _confirmEmailScreenState extends State<ConfirmEmailScreen> with SapiencyInputDecoration {
  
  bool isProgress = false;

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

  Widget getForm(node) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              confirmInput(s1, node, 1),
              SizedBox(
                width: 30,
              ),
              confirmInput(s2, node, 2),
              SizedBox(
                width: 30,
              ),
              confirmInput(s3, node, 3),
              SizedBox(
                width: 30,
              ),
              confirmInput(s4, node, 4),
            ],
          ),
        ],
      ),
    );
  }

  @override
  initState(){
    super.initState();
    s1 = s2 = s3 = s4 = "";
  }

  @override
  Widget build(BuildContext context) {
    final __deviceSize = MediaQuery.of(context).size;
    final __theme = Theme.of(context);
    final node = FocusScope.of(context);
    Map<String, String> map1 = ModalRoute.of(context).settings.arguments;
    String email = map1['email'];
    String nickname = map1['nickname'];

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
                        getForm(node),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            
                            textColor: Colors.white,
                            color: SapiencyTheme.primaryColor,
                            child: isProgress? CircularProgressIndicator(backgroundColor: Colors.white) :Text("Continue"),
                            onPressed: () async {
                              String str_confirm = s1 + s2 + s3 + s4;
                              print("confirm code : $str_confirm");
                              if (str_confirm.length == 4 && !isProgress) {
                                setState((){isProgress = true;});
                                bool f = await Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .ConfirmEmailOrPhone(
                                  context: context,
                                  type: "email",
                                  value: email,
                                  pin:str_confirm,
                                  nickname: nickname,
                                );
                                if(f)
                                Navigator.of(context)
                                    .pushNamed(Routes.INPUT_PHONE_ROUTE,arguments: {"email": email,"nickname": nickname});
                                setState((){isProgress = false; s1 = s2 = s3 = s4 = "";});
                              }
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
                              onPressed: () async {
                                await Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .resendEmailOrPhone(
                                        context: context,
                                        type: "email",
                                        value: email,
                                        nickname: nickname);
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
                        SizedBox(
                          height: __deviceSize.height - 250,
                        ),
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

  Widget confirmInput(String s, node, int pos) {
    TextEditingController txt = TextEditingController();
    txt.selection = TextSelection.fromPosition(TextPosition(offset: -1));
    // txt.text = " ";
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: txt,
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
        ],
        textAlign: TextAlign.center,
        decoration: standardConfirmInputDecoration(),
        style: new TextStyle(
            fontWeight: FontWeight.bold, color: Colors.red, fontSize: 40),
        minLines: 1,
        maxLines: 1,
        showCursor: false,
        onChanged: (v) {
          if (v.length == 2) {
            if (txt.value.selection.baseOffset == 1) {
              txt.text = v.substring(0, 1);
            } else {
              txt.text = v.substring(v.length - 1);
            }
          }
          switch (pos) {
            case 1:
              s1 = txt.text;
              break;
            case 2:
              s2 = txt.text;
              break;
            case 3:
              s3 = txt.text;
              break;
            case 4:
              s4 = txt.text;
              break;
          }
          pos == 4 ? null : node.nextFocus();
        },
        onSaved: (value) => () {
          s = value;
        },
      ),
    );
  }

  Widget _sectionTitle(String text) => Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(text),
      );
}
