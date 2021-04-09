import 'package:flutter/material.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:sapiency/configs/images.dart';

abstract class SignUpScreenTheme extends StatefulWidget {
  SignUpScreenTheme({Key key}) : super(key: key);
  String getTitleText();
  String getSubtitleText();
  Widget getForm();
  Future perform(Function func)async{
    // await this.performFuture(func);
  }
  @override
  _SignUpScreenThemeState createState() =>  _SignUpScreenThemeState();
 
}

 class _SignUpScreenThemeState extends State<SignUpScreenTheme>  with ScreenLoader<SignUpScreenTheme> {

  

  Image getHeaderImage() => Image.asset(
    AppImages.logo,
    width: 50,
    height: 50,
  );
  Future perform(Function func)async{
    await this.performFuture(func);
  }

  Map<String, Widget> getBottomSections(BuildContext context) => {};

  @override
  loader() {
    return AlertDialog(
      title: Text('Wait.. Loading data..'),
    );
  }

  @override
  loadingBgBlur() => 10.0;

  @override
  Widget screen(BuildContext context) {
    final __deviceSize = MediaQuery.of(context).size;
    final __theme = Theme.of(context);
    setState((){
      
    });
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
                    widget.getTitleText(),
                    style: __theme.textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.getSubtitleText(),
                    style: __theme.textTheme.subtitle1,
                  ),

                  widget.getForm(),
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