import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AuthBase {
  Future<void> loginWithFb();
  Future<void> logOut();
  bool get isLoggedIn;
  void updateLoggedState(bool isLogin);
}

class Auth implements AuthBase {
  final _facebookLogin = FacebookLogin();
  Map _userProfile;
  bool _isLoggedIn = false;

  @override
  Future<void> loginWithFb() async {
    final loginResult =
        await _facebookLogin.logInWithReadPermissions(['email']);
    switch (loginResult.status) {
      case FacebookLoginStatus.loggedIn:
        final accessToken = loginResult.accessToken;

        final graphResponse = await http.get(
            "https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$accessToken");
        final profile = json.decode(graphResponse.body);
        _userProfile = profile;
        updateLoggedState(true);
        break;

      case FacebookLoginStatus.cancelledByUser:
        updateLoggedState(false);

        break;

      case FacebookLoginStatus.error:
        updateLoggedState(false);
        break;

    }
  }

  @override
  Future<void> logOut() async {
    await _facebookLogin.logOut();
  }

  @override
  bool get isLoggedIn => _isLoggedIn;

  @override
  void updateLoggedState(bool isLogin) {
    _isLoggedIn = isLogin;
  }
}
