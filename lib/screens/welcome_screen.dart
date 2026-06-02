import 'package:flutter/material.dart';
import 'package:konet/screens/onboadring/first_screen.dart';
import 'package:konet/screens/onboadring/second_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:konet/screens/onboadring/third_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const welcomeScreenId = '/';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController pageController = PageController();

  final List<Widget> _pages = [FirstScreen(), SecondScreen(), ThirdScreen()];
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

  void nextslidefunc({bool nextslide = true}) {
    setState(() {
      if (isFirstslide && !isLastslide) {
        currentslide++;
      } else if (!isFirstslide && !isLastslide) {
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
    return Scaffold(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 568.5,
                width: 375,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (value) => pagecall(context, value),
                  children: _pages,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 56,
                width: 327,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(18),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Color(0xff4F46E5)),
                  ),
                  onPressed: () => nextslidefunc(),
                  child: Text(
                    'get started',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'By continuing, you agree to our quiet terms.',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: 'inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
