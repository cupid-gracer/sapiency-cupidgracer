import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/services/http.dart';

class AuthHttpService extends HttpService {

  AuthHttpService(String apiUrl, AuthProvider authProvider) : super(apiUrl) {
    if (authProvider.isAuth) {
      headers({"Authorization": "Sapiency " + authProvider.token});
    }
  }

}