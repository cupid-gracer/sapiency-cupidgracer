import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/models/user.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/widgets/bottom_navigator.dart';
import 'package:sapiency/widgets/wallet_item.dart';

class WalletScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthProvider>(context, listen: false).user;

    return Scaffold(
      bottomNavigationBar: BottomNavigator(Routes.WALLET_ROUTE),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [SapiencyTheme.primaryColor, SapiencyTheme.secondaryColor]
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("@${user.nickname}", style: _topTextStyle(),),
                    IconButton(
                      iconSize: 18,
                      padding: EdgeInsets.all(0),
                      color: Colors.white,
                      icon: Icon(Icons.add_alert_rounded),
                      onPressed: () {}
                    )
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
                          vertical: 5,
                          horizontal: 15
                      ),
                      enabledBorder:       OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1
                          )
                      ),
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 15,
                        icon: Icon(Icons.copy_rounded, color: Colors.white,),
                        onPressed: () {},
                      )
                    ),
                  )
                ),
                Text("Total wallet value", style: _topTextStyle(),),
                Text("1,082.47 USD", style: _topTextStyle(fontSize: 36)),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _button(label: 'Send', icon: Icons.arrow_upward_rounded),
                      _button(label: 'Receive', icon: Icons.arrow_downward_rounded),
                      _button(label: 'Sell', icon: Icons.shopping_basket),
                      _button(label: 'Deposit', icon: Icons.food_bank)
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
                  Row(
                    children: [
                      Text("${user.wallets.length} tokens "),
                      Text("(\$0.0 USD)"),
                    ],
                  ),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      color: SapiencyTheme.primaryColor,
                      icon: Icon(Icons.search_rounded),
                      onPressed: () {}
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: user.wallets.length,
                itemBuilder: (ctx, idx) => WalletItem(user.wallets[idx])
              )
          )
        ],
      ),
    );
  }

  TextStyle _topTextStyle({double fontSize = 12 }) =>
      TextStyle(color: Colors.white, fontSize: fontSize);

  Widget _button({String label, IconData icon}) =>
      FlatButton(
          onPressed: () {},
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                child: Icon(icon, color: SapiencyTheme.primaryColor, size: 20,),
              ),
              Text(label, style: _topTextStyle(),)
            ],
          )
      );
}
