import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: kActiveColor,
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      home: MainPage(),
    );
  }
}
