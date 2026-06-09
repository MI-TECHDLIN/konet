import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/screens/onboadring/third_screen.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _auth = FirebaseAuth.instance;

  void verify_num() async {
    try {
      await _auth.verifyPhoneNumber(
        forceResendingToken: null,
        timeout: Duration(seconds: 60),
        phoneNumber: '+2349130961180',
        verificationCompleted: (PhoneAuthCredential credentials) async {
          print('verification-completed');

          await _auth.signInWithCredential(credentials);
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger(
            child: SnackBar(content: Text(e.message.toString())),
          );
          print('verification-failed');
          print('error code: ${e.code}');
        },

        codeSent: (String verificationId, int? reftoken) async {
          print(verificationId);
          print(reftoken);
          //  wait for the user to enter the SMS code and Update this UI
          Navigator.push(
            context,
            MaterialPageRoute(builder: (co) => ThirdScreen()),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.message.toString())));
    } catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.toString())));
    }
  }

  String countrycode = '+234';
  TextEditingController number_controller = TextEditingController();

  void countrycodePicker(CountryCode code) {
    setState(() {
      var codec = code.toString() + number_controller.text;
      countrycode = codec;
    });
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
                'your number',
                style: TextStyle(fontFamily: 'InstrumentSerif', fontSize: 48),
              ),

              SizedBox(
                height: 80,
                width: 240,
                child: Text(
                  "we'll send a code to verify your account.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 180,
          left: 20,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0x3916161A)),
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                    ),
                    height: 64,
                    width: 96,
                    child: CountryCodePicker(
                      flagDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      flagWidth: 40,
                      onChanged: countrycodePicker,
                      initialSelection: 'NIG',
                      favorite: ['+234', 'NIG'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 30),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      border: Border.all(color: Color(0xff4F46E5)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 64,
                    width: 203,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: number_controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hint: Text(
                          '(555) 000-0000',
                          style: TextStyle(
                            color: Color(0xff6B7280),
                            fontSize: 20,
                            wordSpacing: 3.0,
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
          top: 290,
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
                    'konet uses your number only for verification.',
                    style: TextStyle(color: Color(0xff6B7280)),
                  ),
                  Text(
                    'We never share it with anyone.',
                    style: TextStyle(color: Color(0xff6B7280)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 38,
          left: 20,
          child: page_btn('continue', verify_num),
        ),
      ],
    );
  }
}
