import 'package:flutter/material.dart';
import 'package:konet/screens/auth/authenication_screen.dart';
import 'package:konet/screens/auth/create_user_screen.dart';
import 'package:konet/screens/auth/login_user.dart';
import 'package:konet/screens/onboadring/first_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';

// ignore: must_be_immutable
class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});
  int current_slide = 0;
  static const welcomeScreenId = '/';

  @override
  State<RegistrationScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<RegistrationScreen> {
  PageController pageController = PageController();

  void nextslidefunc() {
    setState(() {
      if (!isLastslide) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        print('this is a current : $currentslide slide');
      }
    });
  }

  int? auth_index = 0;
  List auth_screen = [LoginUser(), CreateUserScreen()];

  List<Widget> get _pages => [
    FirstScreen(onpress: nextslidefunc),
    AuthenicationScreen(
      signin: () {
        setState(() {
          auth_index = 0;
          if (currentslide == 1) {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            print('this is a current : $currentslide slide');
          }
        });
      },
      signup: () {
        setState(() {
          auth_index = 1;
          if (currentslide == 1) {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            print('this is a current : $currentslide slide');
          } else {}
        });
      },
    ),

    auth_screen[auth_index!],
  ];
  int currentslide = 0;
  int get totalslide => _pages.length;
  bool nextslide = false;
  bool get isFirstslide => currentslide == 0;
  bool get isLastslide => currentslide == totalslide - 1;

  void pagecall(BuildContext context, int slide) {
    setState(() {
      currentslide = slide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffF6F5F1),

      appBar: AppBar(
        titleSpacing: 30,
        backgroundColor: Color(0xffF6F5F1),
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Step ${currentslide + 1} of 4',

            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: DotsIndicator(
              dotsCount: _pages.length,
              position: currentslide.toDouble(),
              decorator: DotsDecorator(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  height: 620.5,
                  width: 375,
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (value) => pagecall(context, value),
                    children: _pages,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
