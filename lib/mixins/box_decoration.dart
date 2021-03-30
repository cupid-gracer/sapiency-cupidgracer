import 'package:flutter/material.dart';

BoxDecoration standardBoxTipDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]);

//Set Card Shadow...
BoxDecoration cardDecoration( {@required BuildContext context, double radius = 3}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    color: Theme.of(context).primaryColor,
    boxShadow: [
      BoxShadow(
        blurRadius: radius,
        spreadRadius: 3,
        color: Theme.of(context)
            .textTheme
            .body1
            .shadows
            .first
            .color, //Colors.grey.withOpacity(0.2),
      )
    ],
  );
}
