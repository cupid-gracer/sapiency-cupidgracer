import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/images.dart';

class NewsFeedScreen extends StatelessWidget {
  Size  __deviceSize;
  ThemeData __sapiencyTheme; 

  @override
  Widget build(BuildContext context) {
     __deviceSize = MediaQuery.of(context).size;
     __sapiencyTheme = SapiencyTheme.getTheme(context);

    return Scaffold(
        backgroundColor: SapiencyTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: SapiencyTheme.backgroundColor,
          title: Image(image: AssetImage(AppImages.letter_sapiency)),
          backwardsCompatibility: false,
          toolbarHeight: 70,
          actions: [
            IconButton(
                icon: Image(image: AssetImage(AppImages.notify_bell)),
                onPressed: () {})
          ],
        ),
        body: SingleChildScrollView(
            child: Expanded(
                child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text:
                              "Early adopters bonus:\n1 USD contributed\n+1 SPCY bonus.\n",
                          style: __sapiencyTheme.textTheme.subtitle1,
                        ),
                        new TextSpan(
                          text: '(read more)',
                          style: new TextStyle(
                              color: __sapiencyTheme.primaryColor,
                              fontWeight: FontWeight.bold),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            NewsCards(),
          ],
        ))));
  }

  Widget NewsCards() {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: SapiencyTheme.primaryColor,
              child: Image(image: AssetImage(AppImages.woman1)),
              foregroundColor: Colors.white,
            ),
            title: Text("User title"),
            subtitle: Text("User subtile"),
            trailing: IconButton(
                icon: Image(image: AssetImage(AppImages.property_for_sale)),
                onPressed: () {}),
          ),
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              height: __deviceSize.width * 3 / 5,
              width: __deviceSize.width,
              image: NetworkImage(
                  "https://static.coindesk.com/wp-content/uploads/2019/03/trading-chart-710x458.jpg"),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      new CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 5.0,
                        percent: 0.2,
                        // center: new Text("100%"),
                        progressColor: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "20 / 200",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Ends in 2 days",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            )
          ]),
          Padding(padding: EdgeInsets.all(25),child: 
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lorem ipsum dolor sit amet", style: __sapiencyTheme.textTheme.subtitle1,),
              Text("Ut enim ad minim veniam, quis nostrud\n exercitation ullamco laboris nisi ut aliquip.", style: __sapiencyTheme.textTheme.bodyText1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$0.25 USD", style: TextStyle(color: __sapiencyTheme.primaryColor)),
                  ElevatedButton (onPressed: (){}, child: Text("Contribute")),
                ],
              ),
            ],
          )
          ),
        ],
      ),
    );
  }
}
