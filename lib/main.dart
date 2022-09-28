import 'package:flutter/material.dart';
import 'package:weatherly/screens/location_screen.dart';
import 'screens/loading_screen.dart';
import 'location_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
    );
  }
}
