import 'package:sapiency/configs/constants.dart';

const HOST_URLS = const {
  // Environments.local: "http://10.0.2.2:8080",
  Environments.local: "http://10.10.10.130:3000",
  Environments.devel: "http://sapiency.softja.eu",
  Environments.production: ""
};

/* Availability and state */
const API_PING = "GET:/api/ping";

/* User registration */
const API_USER_SIGNUP = "PUT:/api/user/signup";
const API_SIGNUP_AVAILABILITY = "GET:/api/signup/available";
const API_SIGNUP_STEP_CREATE = "PUT:/api/signup/step/";
const API_SIGNUP_STEP_CONFIRM = "POST:/api/signup/step/";

/* Authorization */
const API_USER_LOGIN = "POST:/api/user/login";
const API_REGISTER_PIN = "PUT:/api/user/login";
const API_LOGIN_PIN = "POST:/api/user/login";

/* Password recovery  */
const API_PASSWORD_RECOVERY_REQUEST = "PUT:/api/user/password-recovery";
const API_PASSWORD_RECOVERY_CONFIRM = "POST:/api/user/password-recovery";

/* User details */
const API_USER_GET = "GET:/api/user";

/* Wallet */
const API_GET_BALANCE = "GET:/api/wallet";

/* Influencer */
const API_GET_INF_DETAILS = "GET:/api/influencer";
const API_UPDATE_INF_DETAILS = "POST:/api/influencer";
const API_INF_ADD_CROWD_SALE_DETAILS = "PUT:/api/influencer/crowdSale";
const API_INF_GET_CROWD_SALE_DETAILS = "GET:/api/influencer/crowdSale";
