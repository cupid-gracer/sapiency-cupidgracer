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



  Future<bool> loginByEmail({String email, String password}) async {
    final __tokenResponse = await HttpService(Api.API_USER_LOGIN)
      .body({'type': 'EMAIL', 'email': email, 'password': password})
      .execute();
    print("here");

    if ((__tokenResponse['token'] as String).isNotEmpty) {
      await afterLogin(__tokenResponse['token']);
      if(isAuth) return true;
    }

    return false;
  }

    Future<void> signupByEmail({String email, String password, String nickname}) async {
    final __Response = await HttpService(Api.API_USER_SIGNUP)
      .body({'type': 'EMAIL', 'email': email, 'password': password, 'nickname': nickname})
      .execute();

    // if ((__Response['token'] as String).isNotEmpty) {
      // await afterLogin(__tokenResponse['token']);
    }


  Future<bool> tryAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));

    final __preferences = await SharedPreferences.getInstance();

    if (!__preferences.containsKey('token') || JwtDecoder.isExpired(__preferences.getString('token'))) {
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

  Future<void> afterLogin(String token) async {
    _storage['token'] = token;

    final __response = await AuthHttpService(Api.API_USER_GET, this)
        .execute();
    _setStorage(
      token: token,
      user: User.fromJson(__response)
    );

    print("isAuth : $isAuth"); 
    _autoLogout();
    notifyListeners();

    await _saveAuthPreferences();
  }


  void _autoLogout() {
  print("there============ ${ (JwtDecoder.getExpirationDate(token).difference(DateTime.now())).inSeconds}");

    _cancelAuthTimer();
    _authTimer = Timer(Duration(seconds: (JwtDecoder.getExpirationDate(token).difference(DateTime.now())).inSeconds), logout);
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

  void _setStorageFromPreferences(SharedPreferences preferences) =>
      _setStorage(
        token: preferences.getString('token'),
        user: User.fromJson(jsonDecode(preferences.getString('user')))
      );

}

