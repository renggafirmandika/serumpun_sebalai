import 'package:flutter/material.dart';
import 'package:serumpun_sebalai/intro_screens/intro_page1.dart';
import 'package:serumpun_sebalai/intro_screens/intro_page2.dart';
import 'package:serumpun_sebalai/intro_screens/intro_page3.dart';
import 'package:serumpun_sebalai/page/homepage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  static String id = 'IntroScreen';
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                onLastPage = (value == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: const Text('skip'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    }));
                  },
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const SlideEffect(
                      dotColor: Color.fromARGB(160, 255, 255, 255)),
                ),
                onLastPage
                    ? GestureDetector(
                        child: const Text('close'),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomePage();
                          }));
                        },
                      )
                    : GestureDetector(
                        child: const Text('next'),
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
