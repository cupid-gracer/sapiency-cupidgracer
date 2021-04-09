import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:sapiency/configs/constants.dart';
import 'package:sapiency/configs/api.dart';
import 'package:sapiency/widgets/dialog/custom_dialog.dart';

class HttpService {
  static final String _loggerName = "HttpRequest";
  static final Map<String, Function> _methodMatcher = {
    "GET": http.get,
    "POST": http.post,
    "PUT": http.put,
    "DELETE": http.delete
  };

  // final Map<String, String> _headers = {"Content-Type": "application/json", "Content-Length": "35", "Host":"60"};
  final Map<String, String> _headers = {"Content-Type": "application/json", "Accept": "application/json"};
  final Map<String, dynamic> _parameters = {};
  final Map<String, dynamic> _body = {};
  BuildContext context;
  String _requestMethod;
  String _requestUrl;

  HttpService(BuildContext context, String apiUrl) {
    this.context = context;
    var splitIndex = apiUrl.indexOf(":");

    this._requestMethod = apiUrl.substring(0, splitIndex).toUpperCase();
    this._requestUrl = apiUrl.substring(splitIndex + 1);
  }

  HttpService headers(Map<String, String> headers) {
    _headers.addAll(headers);
    return this;
  }

  HttpService parameters(Map<String, dynamic> parameters) {
    _parameters.addAll(parameters);
    return this;
  }
  
  HttpService body(Map<String, dynamic> body) {
    _body.addAll(body);
    return this;
  }
  
  Future<Map<String, dynamic>> execute() async {
    final __requestId = new DateTime.now().millisecondsSinceEpoch;

    try {
      final __requestUrl = _buildUrl();
      

      final http.Response response = _requestMethod == "GET"
          ? await _methodMatcher[_requestMethod](__requestUrl, headers: _headers)
          : await _methodMatcher[_requestMethod](__requestUrl, headers: _headers, body: json.encode(_body));
          // : await _methodMatcher[_requestMethod](__requestUrl, headers: _headers, body: "{\"nickname\": \"cupid\", \"password\": \"password\", \"consents\": [\"marketing\", \"sapiency-1\"], \"language\": \"en\"}");

      log("[$__requestId] Request: $__requestUrl, Method: $_requestMethod, Headers: $_headers, Body: ${json.encode(_body)}", name: _loggerName); 

      if (response.statusCode >= 400) {
        String des = "";
        switch(response.statusCode){
          case 401: des = "Unauthorized!";  break;
          case 404: des = "Server address is incorrect!";  break;
          case 500: des = "Server internal error!";  break;
          default: des = response.reasonPhrase;
        }
        // _alert(title: "Failed", description: response.reasonPhrase, alertType: CustomDialogType.Error);
        _alert(title: "Failed", description: des, alertType: CustomDialogType.Error);
        throw HttpException(response.statusCode, response.reasonPhrase);
      }

      Map<String, dynamic> __responseBody = json.decode(response.body);

      log("[$__requestId] Response: $__responseBody", name: _loggerName);

      if (!__responseBody.containsKey("result")) {
        _alert(title: "Failed", description: "Communication error", alertType: CustomDialogType.Error);
        throw UnexpectedAnswerException();
      } else if (__responseBody["result"] == "fail") {
        _alert(title: "Failed", description: __responseBody["error"], alertType: CustomDialogType.Error);
        throw FailureResponseException(__responseBody["code"], __responseBody["error"]);
      }

      return __responseBody;
    } catch (error) {
      log("[$__requestId] Exception: $error", name: _loggerName, error: error);
      
      throw error;
    }
  }

  void _alert({String title, String description, CustomDialogType alertType}){
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            title: title,
            buttonText: 'Okay',
            description: description,
            alertType: alertType,
            onTap: (){}
          );
        },
      );
  }

  
  String _buildUrl() {
    return _getHostUrl() + _requestUrl.replaceAllMapped(RegExp(r"\{\w+\}"), (match) => (_parameters[match[0].replaceAll(RegExp(r'{|}'), '')] ?? "").toString());
  }

  String _getHostUrl() {
    return HOST_URLS[CURRENT_ENVIRONMENT];
  }

}

class HttpException implements Exception {
  final String message;
  final int httpCode;

  HttpException(this.httpCode, this.message);

  @override
  String toString() {
    return 'HttpException{code: $httpCode, message: $message}';
  }
}

class FailureResponseException implements Exception {
  final String error;
  final int failureCode;

  FailureResponseException(this.failureCode, this.error);

  @override
  String toString() {
    return 'FailureResponseException{failureCode: $failureCode, error: $error}';
  }
}

class UnexpectedAnswerException implements Exception {
  @override
  String toString() {
    return 'UnexpectedAnswerException{}';
  }
}