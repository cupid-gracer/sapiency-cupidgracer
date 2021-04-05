import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/images.dart';
import 'package:sapiency/models/user.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/widgets/app_drawer.dart';
import 'package:sapiency/screens/home/profile/home.dart';
import 'package:sapiency/screens/home/profile/holders.dart';

class ProfileScreen extends StatelessWidget {
  ThemeData __sapiencyTheme;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthProvider>(context, listen: false).user;
    __sapiencyTheme = SapiencyTheme.getTheme(context);  

    return Scaffold(
      backgroundColor: __sapiencyTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: __sapiencyTheme.backgroundColor,
        title: Text("John doe"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Image(image: AssetImage(AppImages.notify_bell)),
              onPressed: () {})
        ],
        elevation: 1.0,
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          _myInfo(),
          _otherInfo(),
        ],
      ),
    );
  }

  Widget _myInfo() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right:10, top:10),
      child: Column(
        children: [
          _myListTile(),
          _myBalance(),
          _myDetail(),
        ],
      ),
    );
  }

  Widget _otherInfo() {
    return Expanded(
        // child: SingleChildScrollView(
            child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: __sapiencyTheme.backgroundColor,
          bottom: TabBar(
            tabs: [
              Tab( text: "Home",),
              Tab( text: "Giveaways",),
              Tab( text: "Holders",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ProfileHomeWidget(),
            Icon(Icons.home),
            Icon(Icons.sentiment_satisfied_outlined),
            Icon(Icons.shopping_cart_outlined),
            // ProfileHolersWidget(),
          ],
        ),
      // ),
    )));
  }

  Widget _myListTile() {
    return Row(
      children: [
        ClipOval(
          // backgroundColor: SapiencyTheme.primaryColor,
          child: Image(
            image: AssetImage(AppImages.man1),
            height: 70,
            width: 70,
            fit: BoxFit.fill,
          ),
          // foregroundColor: Colors.white,
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(
                "John Doe",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                SimpleLineIcons.badge,
                color: SapiencyTheme.primaryColor,
              )
            ]),
            Text(
              "JDOE",
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                color: SapiencyTheme.primaryColor,
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _myBalance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: ListTile(
          title: Container(
            height: 33,
            child: Text(
              "\$523K",
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Text("Market Cap"),
        )),
        Expanded(
            child: ListTile(
          title: Container(
              height: 33,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$0.025",
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  _myBalanceStatus(true, "1.3")
                ],
              )),
          subtitle: Text("Token price"),
        )),
        Expanded(
            child: ListTile(
          title: Container(
            height: 33,
            child: Text(
              "\$523K",
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Text("Volume"),
        )),
      ],
    );
  }

  Widget _myBalanceStatus(bool isUp, String value) {
    Color myColor = isUp ? Colors.green : Colors.red;
    return Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isUp ? AntDesign.caretup : AntDesign.caretdown,
            color: myColor,
            size: 8,
          ),
          Text("% $value", style: TextStyle(fontSize: 10, color: myColor))
        ]);
  }

  Widget _myDetail() {
    return Padding(
        padding: EdgeInsets.only(left:18, right:18, top:10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lorm ipsum dolor sit amet consectetur a dipiscing elitsed doeiu smod tempor in cidi dunt ut labor et dolore magna aliqua.",
              style: __sapiencyTheme.textTheme.subtitle1,
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              direction: Axis.horizontal,
              // runSpacing: 5.0,
              spacing: 5.0,
              children: [
                _chipText("Influnecer"),
                _chipText("Youtuber"),
                _chipText("Creator"),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      "Trade",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: __sapiencyTheme.primaryColor,
                  ),
                ),
                SizedBox(width: 50),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      "Buy (\$15.24)",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: __sapiencyTheme.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          
          ],
        ));
  }

  Widget _chipText(String value) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Text(
        value,
        style: __sapiencyTheme.textTheme.subtitle1,
      ),
    );
  }
}
