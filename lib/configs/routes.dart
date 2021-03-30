import 'package:flutter/material.dart';
import 'package:sapiency/screens/auth/confirm_email.dart';
import 'package:sapiency/screens/auth/confirm_phone.dart';
import 'package:sapiency/screens/auth/login.dart';
import 'package:sapiency/screens/auth/input_phone.dart';
import 'package:sapiency/screens/auth/reset_password.dart';
import 'package:sapiency/screens/auth/reset_password_confirm.dart';
import 'package:sapiency/screens/auth/signup.dart';
import 'package:sapiency/screens/influencer/become_influencer.dart';
import 'package:sapiency/screens/profile/profile.dart';
import 'package:sapiency/screens/wallet/home.dart';
import 'package:sapiency/screens/wallet/wallet.dart';
import 'package:sapiency/screens/welcome.dart';

class Routes {
  static const BECOME_INFLUENCER              = "/become-influencer";
  static const CONFIRM_EMAIL                  = "/confirm-email";
  static const CONFIRM_PHONE                  = "/confirm-phone";
  static const HOME_ROUTE                     = "/home";
  static const LOGIN_ROUTE                    = "/login";
  static const INPUT_PHONE_ROUTE              = "/input-phone";
  static const PROFILE_ROUTE                  = "/profile";
  static const RESET_PASSWORD_ROUTE           = "/reset-password";
  static const RESET_PASSWORD_CONFIRM_ROUTE   = "/reset-password-confirm";
  static const SIGNUP_ROUTE                   = "/signup";
  static const WALLET_ROUTE                   = "/wallet";
  static const WELCOME_ROUTE                  = "/welcome";

  static Map<String, WidgetBuilder> get getRoutes => {
    BECOME_INFLUENCER: (ctx) => BecomeInfluencerScreen(),
    CONFIRM_EMAIL: (ctx) => ConfirmEmailScreen(),
    CONFIRM_PHONE: (ctx) => ConfirmPhoneScreen(),
    HOME_ROUTE: (ctx) => HomeScreen(),
    LOGIN_ROUTE: (ctx) => LoginScreen(),
    INPUT_PHONE_ROUTE: (ctx) => InputPhoneScreen(),
    PROFILE_ROUTE: (ctx) => ProfileScreen(),
    RESET_PASSWORD_ROUTE: (ctx) => ResetPasswordScreen(),
    RESET_PASSWORD_CONFIRM_ROUTE: (ctx) => ResetPasswordConfirmScreen(),
    SIGNUP_ROUTE: (ctx) => SignupScreen(),
    WALLET_ROUTE: (ctx) => WalletScreen(),
    WELCOME_ROUTE: (ctx) => WelcomeScreen(),
  };
}