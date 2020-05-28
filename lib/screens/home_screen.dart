import 'package:flutter/material.dart';

import 'package:dog_path_app/services/auth.dart';
import 'package:dog_path_app/widgets/home_screen_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({@required this.onSignOut, @required this.auth});

  final VoidCallback onSignOut;
  final AuthBase auth;

  Future<void> _logOut(BuildContext context) async {
    auth.updateLoggedState(false);
    await auth.logOut();
    onSignOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff393939),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff393939),
        title: Text(
          'Dog\'s Path',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _logOut(context),
          ),
        ],
      ),
      body: HomeScreenWidget(),
    );
  }
}
