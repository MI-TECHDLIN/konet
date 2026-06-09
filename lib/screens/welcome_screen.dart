import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/screens/onboadring/first_screen.dart';
import 'package:konet/screens/onboadring/last_screen.dart';
import 'package:konet/screens/onboadring/second_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:konet/screens/onboadring/third_screen.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const welcomeScreenId = '/';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController pageController = PageController();
  List<Widget> _pages = [
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(),
    LastScreen(),
  ];

  List<String> btn_text = ['get started', 'continue', 'verify', 'finish'];
  int currentslide = 0;
  int get totalslide => _pages.length;
  bool nextslide = false;
  bool get isFirstslide => currentslide == 0;
  bool get isLastslide => currentslide == totalslide - 3;

  void pagecall(BuildContext context, int slide) {
    setState(() {
      currentslide = slide;
    });
  }

  void nextslidefunc({bool nextslide = true}) {
    setState(() {
      if (isFirstslide && !isLastslide) {
        currentslide++;
      } else {
        currentslide;
      }
    });

    pageController.animateToPage(
      currentslide,
      duration: Duration(milliseconds: 10),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_pages);
    print('lastslide:${isLastslide}');
    print('currentslide:${currentslide}');
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffF6F5F1),

      appBar: AppBar(
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

          // onTap: (p) => {
          //   setState(() {
          //     p == currentslide;
          //   }),
          //   nextslidefunc(slide: currentslide),
          // },
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

                Positioned(
                  bottom: 0,
                  left: 20,
                  child: !isLastslide
                      ? Column(
                          children: [
                            page_btn(btn_text[currentslide], () {
                              nextslidefunc();
                            }),

                            SizedBox(height: 18),
                            Text(
                              'By continuing, you agree to our quiet terms.'
                              '',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontFamily: 'inter',
                              ),
                            ),
                          ],
                        )
                      : Text(''),
                ),
                // Positioned(
                //   bottom: 0,
                //   left: 58,
                //   child:
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
