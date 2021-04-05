import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/validators.dart';
import 'package:sapiency/configs/images.dart';
import 'package:sapiency/models/user.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/widgets/bottom_navigator.dart';
import 'package:sapiency/widgets/wallet_item.dart';
import 'package:sapiency/forms/base_form.dart';
import 'package:sapiency/widgets/forms/input_form_field.dart';

class SendStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final __deviceSize = MediaQuery.of(context).size;
    final __theme = Theme.of(context);

    return Scaffold(
        backgroundColor: __theme.backgroundColor,
        appBar: AppBar(
          title: Text("Success"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.all(65),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  image: AssetImage(AppImages.handshake)),
              Text(
                "Successful transaction",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Lorem ipsum dolor sit amet elit sed do.",
                style: __theme.textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "00.000 TKN",
                style: TextStyle(fontSize: 25, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              Text(
                "00.000 TKN",
                style: __theme.textTheme.subtitle1,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do.",
                style: __theme.textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: ()=>Navigator.of(context).pushNamedAndRemoveUntil(Routes.MAIN_HOME_ROUTE, (route) => false, arguments: {"selectedIndex" : 2}),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Back to Home", style: TextStyle(fontSize: 20),),
                  ))
            ],
          )),
        ));
  }
}
