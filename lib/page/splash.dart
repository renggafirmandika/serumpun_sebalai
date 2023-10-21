import 'package:flutter/material.dart';
import 'package:serumpun_sebalai/page/homepage.dart';
import 'package:serumpun_sebalai/page/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      return HomePage.id;
    } else {
      await prefs.setBool('seen', true);
      return OnBoardingScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return MaterialApp(
              initialRoute: snapshot.data,
              routes: {
                OnBoardingScreen.id: (context) => const OnBoardingScreen(),
                HomePage.id: (context) => const HomePage(),
              },
            );
          }
        });
  }
}
