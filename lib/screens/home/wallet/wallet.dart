import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/forms/base_form.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/images.dart';
import 'package:sapiency/widgets/forms/input_form_field.dart';
import 'package:sapiency/models/user.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/widgets/bottom_navigator.dart';
import 'package:sapiency/widgets/wallet_item.dart';

class WalletScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthProvider>(context, listen: false).user;

    return Column(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: AssetImage(AppImages.man1),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "@${user.nickname}",
                        style: _topTextStyle(),
                      ),
                    ],
                  ),
                  IconButton(
                      iconSize: 18,
                      padding: EdgeInsets.all(0),
                      color: Colors.white,
                      icon: Image(image: AssetImage(AppImages.notify_bell)),
                      onPressed: () => Navigator.of(context).pushNamed(Routes.NEWSFEED_ROUTE))
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 30),
                  height: 25,
                  child: TextFormField(
                    initialValue: user.wallets[0].address,
                    style: _topTextStyle(),
                    decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white60,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 1)),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 15,
                          icon: Icon(
                            Icons.copy_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        )),
                  )),
              Text(
                "Total wallet value",
                style: _topTextStyle(),
              ),
              Text("1,082.47 USD", style: _topTextStyle(fontSize: 36)),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _button(
                        label: 'Send',
                        icon: Image(image: AssetImage(AppImages.data_upload)),
                        onPressed: () =>
                            Navigator.of(context).pushNamed(Routes.SEND_ROUTE)),
                    _button(
                        label: 'Receive',
                        icon:
                            Image(image: AssetImage(AppImages.data_download))),
                    _button(
                        label: 'Sell',
                        icon: Image(image: AssetImage(AppImages.money_bag)),
                        onPressed: () => showModalBottomSheet<void>(
                              context: context,
                              builder: (context) {
                                String data;
                                return sellModal(data, context);
                              },
                            )),
                    _button(
                        label: 'Deposit',
                        icon: Image(image: AssetImage(AppImages.temple))),
                  ],
                ),
              )
            ],
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: isSearch
                      ? TextField()
                      : Row(
                          children: [
                            Text("${user.wallets.length} tokens "),
                            Text("(\$0.0 USD)"),
                          ],
                        ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      color: SapiencyTheme.primaryColor,
                      icon: Image(
                          image: AssetImage(
                              isSearch ? AppImages.remove : AppImages.search)),
                      onPressed: () {
                        setState(() {
                          isSearch = !isSearch;
                        });
                      }),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: user.wallets.length,
                itemBuilder: (ctx, idx) => WalletItem(user.wallets[idx])))
      ],
    );
  }

  TextStyle _topTextStyle({double fontSize = 12}) =>
      TextStyle(color: Colors.white, fontSize: fontSize);

  Widget _button({String label, Image icon, Function onPressed}) => TextButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 5),
              width: 35,
              height: 35,
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: icon
              // Icon(
              //   icon,
              //   color: SapiencyTheme.primaryColor,
              //   size: 20,
              // ),
              ),
          Text(
            label,
            style: _topTextStyle(),
          )
        ],
      ));

  Widget sellModal(data, BuildContext ctx) {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sell toekns"),
                      Container(
                          width: 150,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Last price:"),
                                Text(
                                  "\$0.05",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ]))
                    ],
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: BaseForm(
                    submitText: 'Continue',
                    fields: {
                      'amount': InputFormField(
                        label: 'Amount',
                        comment: "MAX",
                        placeholder: '0.00',
                        suffix: Text("TOKN"),
                        keyboardType: TextInputType.number,
                      ),
                      'price': InputFormField(
                        label: 'Price',
                        placeholder: '0.0',
                        suffix: Text("USD"),
                        keyboardType: TextInputType.number,
                      ),
                    },
                    onSubmit: (data, ctx) async {
                      Navigator.of(ctx).pushNamedAndRemoveUntil(
                          Routes.SEND_STATUS_ROUTE, (route) => false);
                    },
                    onSubmitError: (error) {
                      print(error);
                    },
                  )))
                ],
              ),
            )));
  }
}
