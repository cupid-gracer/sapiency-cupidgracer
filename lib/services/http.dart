import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sapiency/configs/constants.dart';
import 'package:sapiency/configs/api.dart';

class HttpService {
  static final String _loggerName = "HttpRequest";
  static final Map<String, Function> _methodMatcher = {
    "GET": http.get,
    "POST": http.post,
    "PUT": http.put,
    "DELETE": http.delete
  };

  final Map<String, String> _headers = {"Content-Type": "application/json"};
  final Map<String, dynamic> _parameters = {};
  final Map<String, dynamic> _body = {};
  String _requestMethod;
  String _requestUrl;

  HttpService(String apiUrl) {
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

      log("[$__requestId] Request: $__requestUrl, Headers: $_headers, Body: $_body", name: _loggerName);

      final http.Response response = _requestMethod == "GET"
          ? await _methodMatcher[_requestMethod](__requestUrl, headers: _headers)
          : await _methodMatcher[_requestMethod](__requestUrl, headers: _headers, body: json.encode(_body));

      if (response.statusCode >= 400) {
        throw HttpException(response.statusCode, response.reasonPhrase);
      }

      Map<String, dynamic> __responseBody = json.decode(response.body);

      log("[$__requestId] Response: $__responseBody", name: _loggerName);

      if (!__responseBody.containsKey("result")) {
        throw UnexpectedAnswerException();
      } else if (__responseBody["result"] == "fail") {
        throw FailureResponseException(__responseBody["code"], __responseBody["error"]);
      }

      return __responseBody;
    } catch (error) {
      log("[$__requestId] Exception: $error", name: _loggerName, error: error);

      throw error;
    }
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