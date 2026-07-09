//TODO: later user of a validatpr checker for users

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/constant/constant.dart';
import 'package:konet/screens/messaging/chat_screen.dart';
import 'package:konet/screens/onboadring/registration_screen.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

enum avaterlist { first, second, third, fourth, fifth, sixth }

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  final _storeibject = FirebaseFirestore.instance;

  final TextEditingController _usernamecontroller = TextEditingController();
  void updatedisplayname(String displayname) {
    //TODO: tried implementing a displayname function noticed that firebase does not await updatedisplayname func
    // void profilenaming(String name) async {
    final user = _auth.currentUser;

    user!.updateDisplayName(displayname);
  }

  agor_userid() {}

  List _random_generic_num = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  List random_generic_let = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'l',
    'k',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    '0',
  ];

  Future<void> _store_user() async {
    var username = _usernamecontroller.text.substring(0, 3);

    _random_generic_num.shuffle();
    random_generic_let.shuffle();

    var combo =
        random_generic_let[0] +
        _random_generic_num[0] +
        _random_generic_num[1] +
        _random_generic_num[3] +
        random_generic_let[4];
    var config = username + combo;
    print('this is userid: $config');
    try {
      await _storeibject
          .collection('users')
          .doc(username)
          .collection('details')
          .add({
            'email': _auth.currentUser?.email,
            'username': _auth.currentUser?.displayName,
          });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.message.toString())));
    }
  }

  //reusable avatar
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

  avaterlist avater = avaterlist.first;
  List<Color> avatarcolor = [
    Color(0xffFF6A88),

    Color(0xffFF99AC),
    Color(0xffFF6A88),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F5F1),
      body: StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.displayName == null) {
            return Stack(
              children: [
                Positioned(
                  top: 170,
                  left: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'you',
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'InstrumentSerif',
                        ),
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
                  top: 320,
                  left: 140,
                  child: Column(
                    children: [
                      Container(
                        height: 128,
                        width: 132,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          gradient: LinearGradient(colors: avatarcolor),
                        ),
                        child: Image(
                          image: AssetImage('assets/image/profile.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 420,
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
                  top: 480,
                  left: 20,
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

                            avatarcolor = [
                              Color(0xff84FAB0),
                              Color(0xff8FD3F4),
                            ];
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

                            avatarcolor = [
                              Color(0xffA1C4FD),
                              Color(0xffC2E9FB),
                            ];
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

                            avatarcolor = [
                              Color(0xffF093FB),
                              Color(0xffF5576C),
                            ];
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

                            avatarcolor = [
                              Color(0xffFA709A),
                              Color(0xffFEE140),
                            ];
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

                            avatarcolor = [
                              Color(0xff4FACFE),
                              Color(0xff00F2FE),
                            ];
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
                  top: 568,
                  left: 30,
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
                  bottom: 90,
                  left: 45,
                  child: Column(
                    children: [
                      page_btn(btn_text[1], () {
                        updatedisplayname(_usernamecontroller.text);
                        _store_user();
                        Future.delayed(const Duration(seconds: 2)).then((v) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (c) => InboxScreen()),
                          );
                        });
                      }),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasData && snapshot.data!.displayName != null) {
            return InboxScreen();
          } else {
            return RegistrationScreen();
          }
        },
      ),
    );
  }
}
