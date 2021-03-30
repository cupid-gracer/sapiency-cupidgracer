import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapiency/configs/theme.dart';

class PointsList extends StatelessWidget {
  final String title;
  final List<String> items;

  PointsList({this.title, this.items});

  @override
  Widget build(BuildContext context) {
    final __theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: items.map((it) =>
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.check_rounded, color: SapiencyTheme.primaryColor, size: 18),
                    Text('  $it')
                  ],
                )
              )
            ).toList(),
          )
        ]
      ),
    );
  }

}
