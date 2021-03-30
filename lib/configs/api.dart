import 'package:sapiency/configs/constants.dart';

const HOST_URLS = const {
  Environments.local: "http://10.0.2.2:8080",
  // Environments.local: "http://10.10.10.130:3000",
  Environments.devel: "",
  Environments.production: ""
};

const API_PING = "GET:/api/ping";
const API_REGISTRATION_STEP_CONFIRM = "POST:/api/registration/step/{stepId}";
const API_REGISTRATION_STEP_CREATE = "PUT:/api/registration/step/{stepId}";
const API_USER_GET = "GET:/api/user";
const API_USER_LOGIN = "POST:/api/user/login";
const API_USER_SIGNUP = "PUT:/api/user/signup";
