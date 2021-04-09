import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:sapiency/configs/constants.dart' as Constants;
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/providers/influencer.dart';
import 'package:sapiency/screens/auth/login.dart';
import 'package:sapiency/screens/auth/pin.dart';
import 'package:sapiency/screens/home/mainhome.dart';
import 'package:sapiency/screens/splash.dart';
import 'package:sapiency/screens/welcome.dart';

void main() => runApp(MaterialApp(home: SapiencyApp()));

class SapiencyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => InfluencerProvider())
        ],
        child: Consumer<AuthProvider>(
            builder: (ctx, authProvider, _) => ScreenLoaderApp(
                  app: MaterialApp(
                    home: authProvider.isAuth
                        ? (authProvider.isResume
                            ? PinScreen(type: true,)
                            : MainScreen())
                        : FutureBuilder(
                            future: authProvider.tryAutoLogin(),
                            builder: (ctx, authSnapshot) =>
                                authSnapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? SplashScreen()
                                    : WelcomeScreen()),
                    title: Constants.APP_NAME,
                    theme: SapiencyTheme.getTheme(context),
                    routes: Routes.getRoutes,
                  ),
                  globalLoader: AlertDialog(
                    title: Text('Gobal Loader..'),
                  ),
                  globalLoadingBgBlur: 20.0,
                )));
  }
}
