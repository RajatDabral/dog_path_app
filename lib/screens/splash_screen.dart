import 'package:dog_path_app/providers/dog_path_provider.dart';
import 'package:dog_path_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> nextScreen() async {
    await getData();
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => HomeScreen()),
    );
  }

  Future<void> getData() async {
    await Provider.of<DogPathProvider>(context, listen: false).getPath();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void initState() {
    super.initState();
    nextScreen();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .20,
                width: MediaQuery.of(context).size.width * .40,
                child: Image.asset(
                  'assets/images/image.gif',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Dog\'s Path',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 10),
              Text(
                'by',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'VirtuoStack Softwares Pvt. Ltd.',
                style: Theme.of(context).textTheme.headline5,
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
