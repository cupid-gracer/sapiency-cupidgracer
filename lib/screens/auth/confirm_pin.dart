import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapiency/configs/images.dart';
import 'package:passcode_screen/circle.dart';
import 'package:sapiency/widgets/pin/keyboard.dart';
import 'package:passcode_screen/shake_curve.dart';
import 'package:sapiency/configs/routes.dart';

typedef PasswordEnteredCallback = void Function(String text);

class ConfirmPinScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  CircleUIConfig circleUIConfig;
  KeyboardUIConfig keyboardUIConfig;
  String enteredPIN = '';
  int PIN_length = 4;
  String passcode;
  @override
  initState() {
    super.initState();
    passcode = "";
    circleUIConfig = CircleUIConfig(
        borderColor: Colors.white30, fillColor: Colors.white30, circleSize: 30);

    keyboardUIConfig = KeyboardUIConfig(
      digitBorderWidth: 1,
      primaryColor: Colors.white30,
      digitFillColor: Colors.white30,
      digitInnerMargin: EdgeInsets.all(10),
      keyboardRowMargin: EdgeInsets.only(top: 5, left: 4, right: 4),
      // keyboardSize:Size(500,400)
    );

    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: ShakeCurve());
    animation = Tween(begin: 0.0, end: 15.0).animate(curve as Animation<double>)
      ..addStatusListener((status) {
        print(controller.value);
        if (status == AnimationStatus.completed) {
          setState(() {
            enteredPIN = '';
            controller.value = 0;
          });
        }
      })
      ..addListener(() {
        setState(() {
          // the animation object’s value is the changed state
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final __deviceSize = MediaQuery.of(context).size;
    final __theme = Theme.of(context);
    Map<String, String> map = ModalRoute.of(context).settings.arguments;
    passcode = map['pincode'];

    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.pinBG), fit: BoxFit.cover),
            ),
            child: Container()),
        Scaffold(
          appBar: AppBar(
            title: Text("Create your PIN",
                style: TextStyle(color: Colors.white, fontSize: 23),
                textAlign: TextAlign.center),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Center(
                  child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                "Confirm your new PIN",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                // margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 75, right:75),
                height: 60,
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildCircles(),
                ),
              ),
            ],
          ))),
        ),
       
      //  _buildKeyboard(),
        Positioned(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: _buildKeyboard(),
          ),
        )),
        // Positioned(
        //     child: Align(
        //   alignment: Alignment.bottomCenter,
        //   child: _buildDeleteButton(),
        // )),
      ],
    );
  }

  List<Widget> _buildCircles() {
    var list = <Widget>[];
    var config = circleUIConfig;
    var extraSize = animation.value;
    for (int i = 0; i < PIN_length; i++) {

      list.add(
        Expanded(child:
        i < enteredPIN.length
                    ? Container(
                      margin: EdgeInsets.only(left: extraSize),
                      child: Text(
                        enteredPIN.substring(i, i + 1),
                        style: TextStyle(fontSize: 50, color: Colors.white, ),
                        textAlign: TextAlign.center,
                      ),
                    ):
                    Circle(
                        filled: true,
                        circleUIConfig: config,
                        extraSize: extraSize,
                      )
        )
      );

      // list.add(
      //   Container(
      //       margin: EdgeInsets.all(8),
      //       child: Row(
      //         children: [
      //           i < enteredPIN.length
      //               ? Text(
      //                   enteredPIN.substring(i, i + 1),
      //                   style: TextStyle(fontSize: 30, color: Colors.white),
      //                   textAlign: TextAlign.justify,
      //                 )
      //               : Circle(
      //                   // filled: i < enteredPIN.length,
      //                   filled: true,
      //                   circleUIConfig: config,
      //                   extraSize: extraSize,
      //                 ),
      //           SizedBox(width: i < PIN_length - 1 ? 60 : 0)
      //         ],
      //       )),
      // )
      ;
    }
    return list;
  }

  _buildKeyboard() => Container(
        child: Keyboard(
            onKeyboardTap: _onKeyboardButtonPressed,
            keyboardUIConfig: keyboardUIConfig,
            digits: [
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
              '7',
              '8',
              '9',
              'face',
              '0',
              'del'
            ]),
      );

  _onKeyboardButtonPressed(String text) {
    if(text == "face"){
      return;
    }else if(text == "del"){
      _onDeleteCancelButtonPressed();
      return;
    }
    setState(() {
      if (enteredPIN.length < PIN_length) {
        enteredPIN += text;
        if (enteredPIN.length == PIN_length) {
          if(passcode == enteredPIN){
            Navigator.of(context).pushNamed(Routes.LOGIN_ROUTE);
          }
          else
          {
            controller.forward();
          }
          // widget.passwordEnteredCallback(enteredPIN);
        }
      }
    });
  }

  _onDeleteCancelButtonPressed() {
    if (enteredPIN.length > 0) {
      setState(() {
        enteredPIN = enteredPIN.substring(0, enteredPIN.length - 1);
      });
    } else {
      // if (widget.cancelCallback != null) {
      //   widget.cancelCallback();
      // }
    }
  }

  Widget _buildDeleteButton() {
    return Container(
      child: CupertinoButton(
        onPressed: _onDeleteCancelButtonPressed,
        child: Container(
            // margin: widget.keyboardUIConfig.digitInnerMargin,
            child: enteredPIN.length != 0 
                ? Icon(
                    Icons.arrow_back,
                    color: Colors.blue,
                  )
                : null),
      ),
    );
  }

  @override
  didUpdateWidget(ConfirmPinScreen old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}
