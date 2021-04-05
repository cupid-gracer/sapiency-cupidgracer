import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/images.dart';
import 'package:sapiency/models/holder.dart';

class ProfileHomeWidget extends StatelessWidget {
  ThemeData __sapiencyTheme;

  @override
  Widget build(BuildContext context) {
    __sapiencyTheme = SapiencyTheme.getTheme(context);
    int i = 1;

    return Container(
      padding: EdgeInsets.only(left:10, right:10, top:20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Top holders", style: __sapiencyTheme.textTheme.subtitle1,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: Holder.holders
                .map((holder) => homeAvatar(
                    name: holder.fullname,
                    nickname: holder.nickname,
                    avatarURL: holder.avatarURL,
                    number: i++))
                .toList(),
          ),
        )
      ],
    ));
  }

  Widget homeAvatar(
      {String name, String nickname, String avatarURL, int number}) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left:10, right:10, top:10),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    ClipOval(
                      child: Image(
                        image: AssetImage(AppImages.man1),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration: new BoxDecoration(
                        color: __sapiencyTheme.primaryColor,
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Center(
                      child: Text("$number", style: TextStyle(color:Colors.white, fontSize: 10),),
                    ))
              ],
            )),
        Text(name),
        Text(nickname),
      ],
    );
  }
}
