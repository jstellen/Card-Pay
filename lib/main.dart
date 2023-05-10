import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Card',
      theme: ThemeData.light(), // set the light theme as the default
      darkTheme: ThemeData.dark(), // define the dark theme
      themeMode: ThemeMode.system, // use the device theme setting
      home: const MyHomePage(title: 'Add New Card'),
    );
  }
}