import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sapiency/models/user.dart';
import 'package:sapiency/services/auth_http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sapiency/configs/api.dart' as Api;
import 'package:sapiency/services/http.dart';

class AuthProvider with ChangeNotifier {
  Map<String, dynamic> _storage = {};
  Timer _authTimer;

  get token => _storage["token"] as String;
  get user => _storage["user"] as User;
  get isAuth => token != null;
  bool isResume = true;

  Future<bool> loginByEmail(
      {@required BuildContext context, String email, String password}) async {
    final __tokenResponse = await HttpService(context, Api.API_USER_LOGIN).body(
        {'type': 'EMAIL', 'email': email, 'password': password}).execute();

    if ((__tokenResponse['token'] as String).isNotEmpty) {
      await afterLogin(context, __tokenResponse['token']);
      if (isAuth) return true;
    }

    return false;
  }

  Future<bool> loginByPin(
      {@required BuildContext context,String email, String deviceId, String pin}) async {
    final __res = await HttpService(context, Api.API_LOGIN_PIN).body(
        {'type': 'DEVICE_PIN', 'email': email, 'deviceId': deviceId, 'pin' : pin}).execute();
    isResume = false;
    notifyListeners();
    return false;
  }

  Future<bool> RegisterPin(
      {@required BuildContext context,String email, String deviceId, String pin}) async {
    final __res = await HttpService(context, Api.API_REGISTER_PIN)
        .body({'type': 'DEVICE_PIN', 'email': email, 'deviceId': deviceId, 'pin' : pin}).execute();
    isResume = false;
    return false;
  }

  

  

  Future<bool> changeResume()async
  {
    if(isAuth){
      print("change Resume: $isAuth   :  $isResume");
      isResume = true;
      notifyListeners();
      // isResume = false;
    }
    return true;
  }

  // Future<bool> loginByEmail({@required BuildContext context, String email, String password}) async {
  //   // throw error;
  //   await afterLogin("efef");
  //   return true;
  // }

  Future<void> signupByEmail(
      {@required BuildContext context,
      String email,
      String password,
      String nickname}) async {
    var consents = ["marketing", "sapiency-1"];
    print("1");
    await HttpService(context, Api.API_USER_SIGNUP).body({
      "nickname": nickname,
      "password": password,
      "consents": consents,
      "language": "en"
    }).execute();
    print("2");

    // await HttpService(context, Api.API_SIGNUP_AVAILABILITY)
    //   .body({'nickname' : nickname, 'email': email})
    //   .execute();
    print("3");

    await HttpService(context, Api.API_SIGNUP_STEP_CREATE + "EMAIL")
        .body({'nickname': nickname, 'email': email}).execute();
    print("4");

    // final __Response = await HttpService(context, Api.API_USER_SIGNUP)
    //   .body({'type': 'EMAIL', 'email': email, 'password': password, 'nickname': nickname})
    //   .execute();

    // if ((__Response['token'] as String).isNotEmpty) {
    // await afterLogin(__tokenResponse['token']);
  }

  Future<void> resendEmailOrPhone(
      {@required BuildContext context,String type, String value, String nickname}) async {
        String tp = "EMAIL";
        if(tp == "phone") tp = "PHONE";
    await HttpService(context, Api.API_SIGNUP_STEP_CREATE + tp)
        .body({'nickname': nickname, type: value}).execute();
  }

  Future<void> ConfirmEmailOrPhone(
      {@required BuildContext context,String type, String value, String pin, String nickname}) async {
        String tp = "EMAIL";
        if(tp == "phone") tp = "PHONE";
    await HttpService(context, Api.API_SIGNUP_STEP_CONFIRM + tp)
        .body({'nickname': nickname, type: value, "pin":pin}).execute();
  }

  Future<bool> tryAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));

    final __preferences = await SharedPreferences.getInstance();

    if (!__preferences.containsKey('token') ||
        JwtDecoder.isExpired(__preferences.getString('token'))) {
      return false;
    }

    _setStorageFromPreferences(__preferences);

    notifyListeners();
    return true;
  }

  void logout() {
    print("logout");
    _storage["token"] = null;
    _cancelAuthTimer();
    _clearAuthPreferences();

    notifyListeners();
  }

  Future<void> afterLogin(BuildContext context, String token) async {
    _storage['token'] = token;

    // final __response = await AuthHttpService(context, Api.API_USER_GET, this)
    //     .execute();

    final __response = json.decode(
        "{\"result\":\"success\",\"nickname\":\"cupidgracer\",\"email\":\"cupidgracer@gmail.com\",\"phone\":\"1234567890\",\"wallets\":[{\"currency\":\"ETH\",\"value\":\"45.5\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"BTC\",\"value\":\"12.5\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"LTC\",\"value\":\"63.1\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"USDT\",\"value\":\"453\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"USDC\",\"value\":\"127\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"BNB\",\"value\":\"783\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"EFS\",\"value\":\"453\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"ETH\",\"value\":\"7245\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"ADC\",\"value\":\"787\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"AAF\",\"value\":\"778\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"ACA\",\"value\":\"453\",\"lockedvalue\":\"2.5\",\"address\":\"123456-654321-789654\"}]}");
    
    _setStorage(
      token: token,
      user: User.fromJson(__response)
    );

    print("isAuth : $isAuth");
    _autoLogout();
    notifyListeners();

    await _saveAuthPreferences();
  }
  
  // Future<void> afterLogin(BuildContext context, String token) async {
  //   _storage['token'] =
  //       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTMwLCJ1c2VybmFtZSI6ImN1cGlkZ3JhY2VyIiwiZXhwIjoxNjE4NDUwNTc1LCJpYXQiOjE2MTc1ODY1NzV9.UbF26P9AGLLbjg26ObSlqrBpoaMhoFqo4EUxTUyDb2w";

  //   final __response = json.decode(
  //       "{\"result\":\"success\",\"nickname\":\"cupidgracer\",\"email\":\"cupidgracer@gmail.com\",\"phone\":\"1234567890\",\"wallets\":[{\"currency\":\"ETH\",\"value\":\"45.5\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"BTC\",\"value\":\"12.5\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"LTC\",\"value\":\"63.1\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"USDT\",\"value\":\"453\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"USDC\",\"value\":\"127\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"BNB\",\"value\":\"783\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"EFS\",\"value\":\"453\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"ETH\",\"value\":\"7245\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"ADC\",\"value\":\"787\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"AAF\",\"value\":\"778\",\"lockedvalue\":\"2.5\",\"address\":\"0x123784568fwefafnwlenf\"},{\"currency\":\"ACA\",\"value\":\"453\",\"lockedvalue\":\"2.5\",\"address\":\"123456-654321-789654\"}]}");
  //   _setStorage(token: token, user: User.fromJson(__response));

  //   print("isAuth : $isAuth");
  //   _autoLogout();
  //   notifyListeners();

  //   await _saveAuthPreferences();
  // }

  void _autoLogout() {
    _cancelAuthTimer();
    print("logout timer: ${(JwtDecoder.getExpirationDate(token).difference(DateTime.now())).inSeconds}");
    _authTimer = Timer(Duration(seconds: (JwtDecoder.getExpirationDate(token).difference(DateTime.now())).inSeconds), logout);
    // _authTimer = Timer(Duration(seconds: 3600), logout);
  }

  void _cancelAuthTimer() {
    _authTimer?.cancel();
    _authTimer = null;
  }

  Future<void> _saveAuthPreferences() async =>
      await SharedPreferences.getInstance()
        ..setString('token', token)
        ..setString('user', jsonEncode(user));

  Future<void> _clearAuthPreferences() async =>
      await SharedPreferences.getInstance()
        ..clear();

  void _setStorage({String token, User user}) =>
      _storage = {'token': token, 'user': user};

  void _setStorageFromPreferences(SharedPreferences preferences) => _setStorage(
      token: preferences.getString('token'),
      user: User.fromJson(jsonDecode(preferences.getString('user'))));
}
