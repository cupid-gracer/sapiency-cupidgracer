import 'package:flutter/material.dart';
import 'package:sapiency/screens/auth/confirm_email.dart';
import 'package:sapiency/screens/auth/confirm_phone.dart';
import 'package:sapiency/screens/auth/login.dart';
import 'package:sapiency/screens/auth/pin.dart';
import 'package:sapiency/screens/auth/confirm_pin.dart';
import 'package:sapiency/screens/auth/input_phone.dart';
import 'package:sapiency/screens/auth/reset_password.dart';
import 'package:sapiency/screens/auth/reset_password_confirm.dart';
import 'package:sapiency/screens/auth/signup.dart';
import 'package:sapiency/screens/influencer/become_influencer.dart';
import 'package:sapiency/screens/home/profile/profile.dart';
import 'package:sapiency/screens/home/mainhome.dart';
import 'package:sapiency/screens/home/wallet/wallet.dart';
import 'package:sapiency/screens/home/wallet/send.dart';
import 'package:sapiency/screens/home/wallet/sendStatus.dart';
import 'package:sapiency/screens/home/newsfeed/newsfeed.dart';
import 'package:sapiency/screens/welcome.dart';

class Routes {
  static const BECOME_INFLUENCER              = "/become-influencer";
  static const CONFIRM_EMAIL                  = "/confirm-email";
  static const CONFIRM_PHONE                  = "/confirm-phone";
  static const CONFIRM_PIN_ROUTE              = "/confirm-pin";
  static const MAIN_HOME_ROUTE                = "/home";
  static const LOGIN_ROUTE                    = "/login";
  static const INPUT_PHONE_ROUTE              = "/input-phone";
  static const NEWSFEED_ROUTE                 = "/newsfeed";
  static const PROFILE_ROUTE                  = "/profile";
  static const PIN_ROUTE                      = "/pin";
  static const RESET_PASSWORD_ROUTE           = "/reset-password";
  static const RESET_PASSWORD_CONFIRM_ROUTE   = "/reset-password-confirm";
  static const SEND_ROUTE                     = "/send";
  static const SEND_STATUS_ROUTE              = "/send-stauts";
  static const SIGNUP_ROUTE                   = "/signup";
  static const WALLET_ROUTE                   = "/wallet";
  static const WELCOME_ROUTE                  = "/welcome";

  static Map<String, WidgetBuilder> get getRoutes => {
    BECOME_INFLUENCER:            (ctx) => BecomeInfluencerScreen(),
    CONFIRM_EMAIL:                (ctx) => ConfirmEmailScreen(),
    CONFIRM_PHONE:                (ctx) => ConfirmPhoneScreen(),
    CONFIRM_PIN_ROUTE:            (ctx) => ConfirmPinScreen(),
    MAIN_HOME_ROUTE:              (ctx) => MainScreen(),
    LOGIN_ROUTE:                  (ctx) => LoginScreen(),
    INPUT_PHONE_ROUTE:            (ctx) => InputPhoneScreen(),
    NEWSFEED_ROUTE:               (ctx) => NewsFeedScreen(),
    PIN_ROUTE:                    (ctx) => PinScreen(),
    PROFILE_ROUTE:                (ctx) => ProfileScreen(),
    RESET_PASSWORD_ROUTE:         (ctx) => ResetPasswordScreen(),
    RESET_PASSWORD_CONFIRM_ROUTE: (ctx) => ResetPasswordConfirmScreen(),
    SEND_ROUTE:                   (ctx) => SendScreen(),
    SEND_STATUS_ROUTE:            (ctx) => SendStatusScreen(),
    SIGNUP_ROUTE:                 (ctx) => SignupScreen(),
    WALLET_ROUTE:                 (ctx) => WalletScreen(),
    WELCOME_ROUTE:                (ctx) => WelcomeScreen(),
  };
}