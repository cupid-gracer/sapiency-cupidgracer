import 'package:flutter/material.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/widgets/buttons/standard.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/images.dart';

class WelcomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  final __deviceSize = MediaQuery.of(context).size;
  bool isResponsive = (__deviceSize.width / __deviceSize.height > 0.5 ? true : false);
    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.welcomeBG),
                fit: BoxFit.cover)),
      ),
      Container(
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              // color: Colors.red,
              height: isResponsive? 100 : 250,
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 40)),
                  SizedBox(
                    width: 200,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: SapiencyTheme.primaryColor,
                      child: Text("Sign up"),
                      onPressed: (){
                        Navigator.of(context).pushNamed(Routes.SIGNUP_ROUTE);
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 30)),
                  RaisedButton(
                    textColor: SapiencyTheme.primaryColor,
                    color: Colors.white,
                    child: Text("login"),
                    onPressed: (){
                      Navigator.of(context).pushNamed(Routes.LOGIN_ROUTE);
                      
                    },
                  ),
                  // StandardButton(
                  //   label: 'Sign up',
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed(Routes.SIGNUP_ROUTE);
                  //   },
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
