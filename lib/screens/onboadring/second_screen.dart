import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/constant/constant.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({required this.onpress});
  VoidCallback onpress;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();

  bool _finished = false;
  //signup funtion
  void _sign_upser() async {
    // // var acs=ActionCodeSettings(url: ,
    // linkDomain: '',
    // androidInstallApp: true,
    // androidPackageName: ''

    // )
    try {
      // await _auth.signInWithEmailAndPassword(
      //   email: 'ezechukwumiracle52@gmail.com',
      //   password: 'ppppppp',
      // );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.message.toString())));
    } catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget password_log = Stack(
      children: [
        Positioned(
          top: 30,
          left: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'choose password',
                style: TextStyle(fontFamily: 'InstrumentSerif', fontSize: 57),
              ),

              const Text(
                'make it strong and unique.',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 400,
          left: 15,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),

              borderRadius: BorderRadius.circular(16),
            ),
            height: 55,
            width: 100,
            child: TextField(
              obscureText: true,
              obscuringCharacter: '.',
              controller: _password_controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hint: const Text(
                  '.........',
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
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: Column(
            children: [
              page_btn(btn_text[1], () {
                print('this is email ${_email_controller.text}');
                print('this is password ${_password_controller.text}');
                widget.onpress();
              }),
            ],
          ),
        ),
      ],
    );

    Widget email_log = Stack(
      children: [
        Positioned(
          top: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'your email',
                style: TextStyle(fontFamily: 'InstrumentSerif', fontSize: 48),
              ),

              SizedBox(
                height: 80,
                width: 300,
                child: const Text(
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
                        hint: const Text(
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
              const Text(
                'i',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff4F46E5),
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  const Text(
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
                setState(() {
                  _finished = true;
                });
              }),
            ],
          ),
        ),
      ],
    );
    return _finished == true ? password_log : email_log;
  }
}
