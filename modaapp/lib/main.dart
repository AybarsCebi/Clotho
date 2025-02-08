import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modaapp/BottomNavigationBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modaapp/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDSbI_yu1u_C7NC8IjbiQy3n8xymqWPArg',
              appId: '1:539673882354:android:742aebd40ccb67c15f6a6b',
              messagingSenderId: '539673882354',
              projectId: 'clotho-67236'))
      : await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //primaryColor: Colors.purple[200],
          ),
      home: LoginPage()
    );
  }
}
