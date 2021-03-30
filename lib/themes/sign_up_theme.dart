import 'package:flutter/material.dart';

abstract class SignUpScreenTheme extends StatelessWidget {

  Image getHeaderImage() => Image.asset(
    "assets/images/logo.png",
    width: 50,
    height: 50,
  );

  String getTitleText();
  String getSubtitleText();
  Widget getForm();
  Map<String, Widget> getBottomSections(BuildContext context) => {};

  @override
  Widget build(BuildContext context) {
    final __deviceSize = MediaQuery.of(context).size;
    final __theme = Theme.of(context);

    return Scaffold(
        backgroundColor: __theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
              width: __deviceSize.width - 60,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeaderImage(),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    getTitleText(),
                    style: __theme.textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    getSubtitleText(),
                    style: __theme.textTheme.subtitle1,
                  ),
                  getForm(),
                  ...getBottomSections(context).entries.map((entry) =>
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _sectionTitle(entry.key),
                        entry.value
                      ],
                    )
                  ).toList()
                ],
              )
          ),
        )
    );
  }

  Widget _sectionTitle(String text) =>
      Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(text),
      );

}