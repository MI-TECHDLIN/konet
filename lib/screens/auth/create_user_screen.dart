import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/constant/constant.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

enum avaterlist { first, second, third, fourth, fifth, sixth }

class CreateUserScreen extends StatefulWidget {
  CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  int _screen_index = 0;

  Widget reusablecustomavatar({
    avaterlist? avater,
    avaterlist avaterstate = avaterlist.first,
    final List<Color>? color,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 0),
      padding: EdgeInsets.all(6),
      height: 60,
      width: 60,
      decoration: avater == avaterstate
          ? BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xff4F46E5), width: 2),
              borderRadius: BorderRadius.circular(999),
            )
          : BoxDecoration(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          gradient: LinearGradient(colors: color!),
        ),
      ),
    );
  }

  // final bool _finished = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void createUSer(String sEmail, String sPassword) async {
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

  //TODO: tried implementing a displayname function noticed that firebase does not await updatedisplayname func
  // void profilenaming(String name) async {
  //   final user = _auth.currentUser;

  //   user!.updateDisplayName('miracle');
  // }

  Widget screen_func({
    required Widget firststate,
    required Widget secondstate,
    required Widget thirdstate,
  }) {
    List<Widget> screens = [firststate, secondstate, thirdstate];
    return screens[_screen_index];
  }

  avaterlist avater = avaterlist.first;
  List<Color> avatarcolor = [
    Color(0xffFF6A88),

    Color(0xffFF99AC),
    Color(0xffFF6A88),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // profilenaming(_usernamecontroller.text);
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
                  _screen_index++;
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
    //profile widget

    Widget profileSetup = Stack(
      children: [
        Positioned(
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'you',
                style: TextStyle(fontSize: 50, fontFamily: 'InstrumentSerif'),
              ),
              SizedBox(height: 5),
              const Text(
                'how should people see you?',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),

        Positioned(
          top: 130,
          left: 125,
          child: Column(
            children: [
              Container(
                height: 128,
                width: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: LinearGradient(colors: avatarcolor),
                ),
                child: Image(image: AssetImage('assets/image/profile.png')),
              ),
            ],
          ),
        ),
        Positioned(
          top: 230,
          left: 213,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Image(image: AssetImage('assets/image/cam.png')),
          ),
        ),

        Positioned(
          top: 290,
          left: 8,
          child: Row(
            children: [
              //1
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.first;

                    avatarcolor = [
                      Color(0xffFF6A88),

                      Color(0xffFF99AC),
                      Color(0xffFF6A88),
                    ];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.first,
                  color: [
                    Color(0xffFF6A88),
                    Color(0xffFF99AC),
                    Color(0xffFF6A88),
                  ],
                ),
              ),

              //2
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.second;

                    avatarcolor = [Color(0xff84FAB0), Color(0xff8FD3F4)];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.second,
                  color: [Color(0xff84FAB0), Color(0xff8FD3F4)],
                ),
              ),
              //3
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.third;

                    avatarcolor = [Color(0xffA1C4FD), Color(0xffC2E9FB)];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.third,
                  color: [Color(0xffA1C4FD), Color(0xffC2E9FB)],
                ),
              ),
              //4
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.fourth;

                    avatarcolor = [Color(0xffF093FB), Color(0xffF5576C)];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.fourth,
                  color: [Color(0xffF093FB), Color(0xffF5576C)],
                ),
              ),
              //5
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.fifth;

                    avatarcolor = [Color(0xffFA709A), Color(0xffFEE140)];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.fifth,
                  color: [Color(0xffFA709A), Color(0xffFEE140)],
                ),
              ),
              //6
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.sixth;

                    avatarcolor = [Color(0xff4FACFE), Color(0xff00F2FE)];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.sixth,
                  color: [Color(0xff4FACFE), Color(0xff00F2FE)],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 400,
          left: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'YOUR  USERNAME',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'inter',
                  ),
                ),
              ),
              Container(
                height: 55,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextField(
                  controller: _usernamecontroller,
                  decoration: InputDecoration(
                    hint: Container(
                      margin: EdgeInsets.only(left: 30),
                      child: const Text(
                        'Alex Rivers',
                        style: TextStyle(
                          color: Color(0x826B7280),
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
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
                createUSer(_email_controller.text, _password_controller.text);
              }),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Color(0xffF6F5F1),
      body: screen_func(
        firststate: emailLog,
        secondstate: passwordLog,
        thirdstate: profileSetup,
      ),
    );
  }
}
