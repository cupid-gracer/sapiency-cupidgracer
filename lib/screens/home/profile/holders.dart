import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/images.dart';
import 'package:sapiency/models/holder.dart';

class ProfileHolersWidget extends StatelessWidget {
  ThemeData __sapiencyTheme;

  @override
  Widget build(BuildContext context) {
    __sapiencyTheme = SapiencyTheme.getTheme(context);
    int i = 1;

    return ListView(
      children: Holder.holders
          .map((holder) => _itemHoler(
              name: holder.fullname,
              symbol: holder.symbol,
              price: holder.price,
              avatarURL: holder.avatarURL,
              number: i++))
          .toList(),
    );
  }

  Widget _itemHoler(
      {String name,
      String symbol,
      String price,
      String avatarURL,
      int number}) {
    return Container(
      decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
                bottom: BorderSide(width: 0, color: Colors.grey)
            )
        ),
      child: 
     ListTile(
      leading: myCircleAvatar(number),
      title: Text(
        name,
        style: __sapiencyTheme.textTheme.subtitle1,
      ),
      subtitle: Text(
        symbol,
        style: __sapiencyTheme.textTheme.subtitle1,
      ),
      trailing: Column(
        children: [
          Text(
            "Token",
            style: __sapiencyTheme.textTheme.subtitle1,
          ),
          Text(
            price,
            style: __sapiencyTheme.textTheme.subtitle2,
          )
        ],
      ),
    )
    ,);
  }

  Widget myCircleAvatar(int number) {
    return Container(
      // height: 10,
      // width: 10,
        // margin: EdgeInsets.all(10),
        child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Wrap(children: [
          SizedBox(width: 10),
          CircleAvatar(child: Image(image: AssetImage(AppImages.man1))),
        ],),
        Container(
          height: 18,
          width: 18,
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
    ));
  }
}
