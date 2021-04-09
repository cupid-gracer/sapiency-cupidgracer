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

class SendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthProvider>(context, listen: false).user;

    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        SapiencyTheme.primaryColor,
                        SapiencyTheme.secondaryColor
                      ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          iconSize: 30,
                          padding: EdgeInsets.all(0),
                          color: Colors.white,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(
                        "Send",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Container(
                        child: Text("                     ")
                      )
                      // IconButton(
                      //     iconSize: 18,
                      //     padding: EdgeInsets.all(0),
                      //     color: Colors.white,
                      //     icon: Image(image: AssetImage(AppImages.notify_bell)),
                      //     onPressed: () {}),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _personInfo(
                          imgURL: AppImages.man1,
                          name: "Me",
                          volume: "0.0025 TND",
                          exchange: "\$123.456 USD"),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 100),
                        child: Text("--------",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      _personInfo(
                          imgURL: AppImages.woman1,
                          name: "Cecilia Pozo",
                          volume: "0.00000 TND",
                          exchange: "\$00,000 USD"),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              )),
          Expanded(
              child: SingleChildScrollView(
            child:
                Padding(padding: EdgeInsets.all(30), child: sendInfo(context)),
          ))
        ],
      ),
    );
  }

  Widget _personInfo(
          {String imgURL, String name, String volume, String exchange}) =>
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                  style: BorderStyle.solid,
                ),
              ),
              child: Image(image: AssetImage(imgURL), fit: BoxFit.cover),
            ),
            SizedBox(
              height: 10,
            ),
            Text(name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 8,
            ),
            Text(volume, style: TextStyle(color: Colors.white, fontSize: 15)),
            SizedBox(
              height: 3,
            ),
            Text(exchange, style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      );

  static BaseForm sendInfo(BuildContext ctx) => BaseForm(
        // values: Provider.of<InfluencerProvider>(ctx, listen: false).data,
        submitText: 'Send',
        fields: {
          'address': InputFormField(
              label: '',
              suffix: Image(image:AssetImage(AppImages.barcode)),
              placeholder: 'ETH address, username or email',
              keyboardType: TextInputType.text,
              // onPressedSuffix:()=>Navigator.of(ctx).pushNamed(Routes.CONFIRM_PIN_ROUTE)
              ),
          'amount': InputFormField(
              label: 'Amount',
              placeholder: '0.00',
              comment: "25% 50% 75% Max",
              keyboardType: TextInputType.number),
          'note': InputFormField(
              label: 'Note',
              placeholder: 'Write a note',
              lines: 5,
              keyboardType: TextInputType.text),
        },
        onSubmit: (data, ctx) {
          Navigator.of(ctx).pushNamed(Routes.SEND_STATUS_ROUTE);
          // gotoNext(data, ctx, 1);
        },
        onSubmitError: (error) {
          print(error);
        },
      );
}
