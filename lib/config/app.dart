import 'package:flutter/material.dart';
import 'package:weather_app/config/router.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fintech Pos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        accentColor: Colors.lightBlueAccent
      ),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
