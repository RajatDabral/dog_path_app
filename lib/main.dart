import 'package:flutter/material.dart';

import './screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import './providers/dog_path_provider.dart';

void main() => runApp(DogPathApp());

class DogPathApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DogPathProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blueGrey,
          textTheme: TextTheme(
            headline3: TextStyle(
              color: Colors.white54,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
            headline5: TextStyle(
              fontSize: 20,
              color: Colors.white54,
              wordSpacing: 0.0,
            ),
          ),
        ),
        title: 'Dog\'sPath',
        home: SplashScreen(),
      ),
    );
  }
}
