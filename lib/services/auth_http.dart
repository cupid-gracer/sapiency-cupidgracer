import 'package:flutter/material.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/services/http.dart';

class AuthHttpService extends HttpService {

  AuthHttpService(BuildContext context, String apiUrl, AuthProvider authProvider) : super(context, apiUrl) {
    if (authProvider.isAuth) {
      headers({"Authorization": "Sapiency " + authProvider.token});
    }
  }

}