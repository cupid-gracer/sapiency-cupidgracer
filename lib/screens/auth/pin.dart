import 'dart:async';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/models/user.dart';
import 'package:sapiency/configs/images.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/shake_curve.dart';
import 'package:sapiency/widgets/pin/keyboard.dart';

typedef PasswordEnteredCallback = void Function(String text);

class PinScreen extends StatefulWidget {
  /**
   * type:  true => login pin widget, false => create new pin
   */
  final bool type;

  const PinScreen({Key key, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen>
    // with SingleTickerProviderStateMixin
    with
        ScreenLoader<PinScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  AnimationController controller;
  Animation<double> animation;
  CircleUIConfig circleUIConfig;
  KeyboardUIConfig keyboardUIConfig;
  String enteredPIN = '';
  int PIN_length = 4;
  User user;

  @override
  initState() {
    super.initState();
    user = Provider.of<AuthProvider>(context, listen: false).user;

    enteredPIN = "";

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

    // controller = AnimationController(
    //     duration: const Duration(milliseconds: 500), vsync: this);
    // final Animation curve =
    //     CurvedAnimation(parent: controller, curve: ShakeCurve());
    // animation = Tween(begin: 0.0, end: 10.0).animate(curve as Animation<double>)
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       setState(() {
    //         enteredPIN = '';
    //         controller.value = 0;
    //       });
    //     }
    //   })
    //   ..addListener(() {
    //     setState(() {
    //       // the animation object’s value is the changed state
    //     });
    //   });
  }

  @override
  loader() {
    return  CircularProgressIndicator(backgroundColor: Colors.white);
    // return AlertDialog(
    //   title: Text('Wait.. Loading data..'),
    // );
  }

  @override
  loadingBgBlur() => 10.0;

  static Future<String> getDeviceId() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    return identifier;
  }

  @override
  Widget screen(BuildContext context) {
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
            title: Text(
                widget.type ? "Signin with your PIN" : "Create your PIN",
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
                widget.type ? "Type your pin" : "Type a new PIN",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                // margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 75, right: 75),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildCircles(),
                ),
              ),
            ],
          ))),
        ),
        Positioned(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: _buildKeyboard(),
          ),
        )),
      ],
    );
  }

  List<Widget> _buildCircles() {
    var list = <Widget>[];
    var config = circleUIConfig;
    // var extraSize = animation.value;
    for (int i = 0; i < PIN_length; i++) {
      list.add(Expanded(
          child: i < enteredPIN.length
              ? Text(
                  enteredPIN.substring(i, i + 1),
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                )
              : Circle(
                  // filled: i < enteredPIN.length,
                  filled: true,
                  circleUIConfig: config,
                  // extraSize: extraSize,
                )));
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

  _onKeyboardButtonPressed(String text) async {
    if (text == "face") {
      return;
    } else if (text == "del") {
      _onDeleteCancelButtonPressed();
      return;
    }
    setState(() {
      if (enteredPIN.length < PIN_length) {
        enteredPIN += text;
      }
    });
    if (enteredPIN.length == PIN_length) {
      String str = enteredPIN;
      // await this.performFuture(__test(str));
      // enteredPIN = "";
      String device_id = await getDeviceId();
      if (widget.type) {
        await this.performFuture(() =>
            Provider.of<AuthProvider>(context, listen: false).loginByPin(
                context: context,
                email: user.email,
                deviceId: device_id,
                pin: str));
      } else {
        Navigator.of(context)
            .pushNamed(Routes.CONFIRM_PIN_ROUTE, arguments: {"pincode": str});
      }
      // widget.passwordEnteredCallback(enteredPIN);
    }
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
  didUpdateWidget(PinScreen old) {
    setState(() {
      enteredPIN = "";
    });
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
  }

  @override
  dispose() {
    enteredPIN = "";
    super.dispose();
  }
}
