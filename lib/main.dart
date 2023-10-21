import 'package:flutter/material.dart';
import 'package:serumpun_sebalai/page/homepage.dart';
import 'package:serumpun_sebalai/page/onboarding_screen.dart';
import 'package:serumpun_sebalai/page/splash.dart';
import 'package:serumpun_sebalai/utils/userSettings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
