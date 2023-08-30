import 'package:flutter/material.dart';
import 'package:modaapp/HomePage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple[200],
      ),
      home: HomePage(),
    );
  }
}
