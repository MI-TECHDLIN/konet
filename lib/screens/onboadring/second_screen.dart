import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/constant/constant.dart';
import 'package:konet/screens/onboadring/third_screen.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({required this.onpress});
  VoidCallback onpress;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _email_controller = TextEditingController();

  void sign_upser() async {
    // // var acs=ActionCodeSettings(url: ,
    // linkDomain: '',
    // androidInstallApp: true,
    // androidPackageName: ''

    // )
    try {
      await _auth.signInWithEmailAndPassword(
        email: 'ezechukwumiracle52@gmail.com',
        password: 'ppppppp',
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.message.toString())));
    } catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'your email',
                style: TextStyle(fontFamily: 'InstrumentSerif', fontSize: 48),
              ),

              SizedBox(
                height: 80,
                width: 300,
                child: Text(
                  "we'll use this to secure your account.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 160,
          left: 20,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      border: Border.all(color: Color(0xff4F46E5)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 64,
                    width: 330,
                    child: TextField(
                      controller: _email_controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hint: Text(
                          'email@examplecom',
                          style: TextStyle(
                            color: Color(0xff6B7280),
                            fontSize: 20,
                            wordSpacing: 3.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 22,
          top: 250,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'i',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff4F46E5),
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    'We never share your email with anyone.',
                    style: TextStyle(color: Color(0xff6B7280)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: Column(
            children: [
              page_btn(btn_text[1], () {
                widget.onpress();
              }),
            ],
          ),
        ),
      ],
    );
  }
}
