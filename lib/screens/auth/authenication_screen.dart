import 'package:flutter/material.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

class AuthenicationScreen extends StatefulWidget {
  AuthenicationScreen({super.key, required this.signin, required this.signup});
  VoidCallback signup;
  VoidCallback signin;

  @override
  State<AuthenicationScreen> createState() => _AuthenicationScreenState();
}

class _AuthenicationScreenState extends State<AuthenicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F5F1),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 20,
              child: Column(
                children: [
                  const Text(
                    'konet',
                    style: TextStyle(
                      fontFamily: 'InstrumentSerif',
                      fontSize: 90,
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    width: 160,
                    child: const Text(
                      'Welcome back to your quiet digital space.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 25,
              top: 400,
              child: Column(
                children: [
                  page_btn(
                    'login',
                    () => setState(() {
                      widget.signin();
                      print('signined in');
                    }),
                  ),
                  SizedBox(height: 15),
                  page_btn(
                    'Sign up',
                    () => setState(() {
                      print('signined in');
                      widget.signup();
                    }),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 25),
                    height: 50,
                    width: 250,
                    child: Text(
                      textAlign: TextAlign.center,
                      'By logging in, you agree to our quiet terms and privacy policy',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
