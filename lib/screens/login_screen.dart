import 'package:dog_path_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  Future<void> _loginWithFB(BuildContext context) async {
    final authProvider = Provider.of<AuthBase>(context, listen: false);
    await authProvider.loginWithFb();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthBase>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: authProvider.isLoggedIn
              ? HomeScreen()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildContent(context),
                ),
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return [
      Text(
        "Sign In",
        style: TextStyle(
          fontSize: 28,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 35),
      Text(
        "Sign In with your facebook account",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 20),
      Container(
        margin: EdgeInsets.only(
          left: width * .1,
          right: width * .1,
        ),
        child: RaisedButton(
          padding: EdgeInsets.only(left: 10),
          color: Color(0xff39569c),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                'assets/images/facebook-logo.png',
              ),
              Text(
                "Sign In With Facebook",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(
                  'assets/images/facebook-logo.png',
                ),
              ),
            ],
          ),
          onPressed: () => _loginWithFB(context),
        ),
      ),
    ];
  }
}
