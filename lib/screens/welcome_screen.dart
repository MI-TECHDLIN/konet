import 'package:flutter/material.dart';
import 'package:konet/screens/onboadring/first_screen.dart';
import 'package:konet/screens/onboadring/second_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  static const welcomeScreenId = '/';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F5F1),

      appBar: AppBar(
        backgroundColor: Color(0xffF6F5F1),

        title: SmoothPageIndicator(
          controller: pageController,
          count: 4,
          effect: WormEffect(),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 568.5,
              width: 375,
              child: PageView(children: [FirstScreen(), SecondScreen()]),
            ),
          ],
        ),
      ),
    );
  }
}
