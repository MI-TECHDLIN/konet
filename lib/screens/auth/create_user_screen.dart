import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/constant/constant.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  int _screen_index = 0;

  // final bool _finished = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void createUSer(String sEmail, String sPassword) async {
    '''
this functions is
been  triggered and generates users
for auth

''';
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
        email: sEmail,
        password: sPassword,
      );
      print('${newUser.user!.email}. User created');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.message.toString())));
    } catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.toString())));
    }
  }

  Widget screen_func({
    required Widget firststate,
    required Widget secondstate,
  }) {
    List<Widget> screens = [firststate, secondstate];
    return screens[_screen_index];
  }

  @override
  Widget build(BuildContext context) {
    //password widget

    Widget passwordLog = Stack(
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
              border: Border.all(color: const Color(0x95000000)),
              color: Color(0xffFFFFFF),

              borderRadius: BorderRadius.circular(13),
            ),
            height: 55,
            width: 150,
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
                setState(() {
                  createUSer(_email_controller.text, _password_controller.text);
                });
              }),
            ],
          ),
        ),
      ],
    );
    //email widget

    Widget emailLog = Stack(
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
                      keyboardType: TextInputType.emailAddress,
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
                  _screen_index++;
                });
              }),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Color(0xffF6F5F1),
      body: screen_func(firststate: emailLog, secondstate: passwordLog),
    );
  }
}
