import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});

  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isUserLogged = false;

  void _checkLoggedInStatus(bool isLogged) {
    setState(() {
      _isUserLogged = isLogged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isUserLogged
        ? HomeScreen(
            onSignOut: () => _checkLoggedInStatus(false),
            auth: widget.auth,
          )
        : LoginScreen(
            onSignIn: _checkLoggedInStatus,
            auth: widget.auth,
          );
  }
}
