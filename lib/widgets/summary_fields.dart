import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapiency/configs/theme.dart';

class SummaryFields extends StatelessWidget {
  final Map<String, String> fields;

  SummaryFields(this.fields);

  @override
  Widget build(BuildContext context) {
    final __theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: fields.entries.map((entry) =>
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key ?? '',
                    style: __theme.textTheme.caption
                  ),
                  Text(
                    entry.value ?? '',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)
                  )
                ],
              )
            )
          ).toList(),
        ),
      )
    );
  }

}
