import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/constant/constant.dart';
import 'package:konet/screens/messaging/inbox_screen.dart';
import 'package:konet/screens/onboadring/registration_screen.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

enum avaterlist { first, second, third, fourth, fifth, sixth }

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  //auth
  final _storeibject = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //variables
  avaterlist avater = avaterlist.first;
  var grad1 = 0xffFF6A88;
  User? get user => _auth.currentUser;
  var userid = '';

  String get config => _auth.currentUser!.uid;

  var grad2 = 0xFFFF6AC8;
  final TextEditingController _usernamecontroller = TextEditingController();

  // functions
  void updatedisplayname(String displayname) {
    user!.updateDisplayName(displayname);
  }

  String useridGenertaor() {
    '''
thought of a method that can actually generate userid based on user input

how does this algorithm works
2 detail from string and num;
and a list of random_numbers to get your id
''';
    List<String> randomStr = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'l',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
    ];
    List<String> randomoNum = [
      '0',
      '1',
      '2',
      '3',
      ' 4',
      ' 5',
      '6',
      '7',
      '8',
      '9',
    ];
    randomStr.shuffle();
    randomoNum.shuffle();
    var twoRandomstr = randomStr[0] + randomStr[1];
    var twoRandomNum = randomoNum[0] + randomoNum[1];
    setState(() {
      userid = 'KONET-$twoRandomstr$twoRandomNum';
    });
    print(userid);
    return userid;
  }

  Future<void> _store_user() async {
    '''
this function basically stores users
and gives a generic 
''';

    var profileColor = [grad1, grad2];

    print('this is userid: $config');
    try {
      await _storeibject
          .collection('database')
          .doc('123')
          .collection('users')
          .doc(config)
          .collection('details')
          .add({
            'email': _auth.currentUser?.email,
            'username': _usernamecontroller.text,
            'profile-color': profileColor,
            'userid': userid,
          });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.message.toString())));
    }
  }

  //reusable avatar
  Widget reusablecustomavatar({
    avaterlist? avater,
    avaterlist avaterstate = avaterlist.first,
    int? color1,
    int? color2,
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
          gradient: LinearGradient(colors: [Color(color1!), Color(color2!)]),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    useridGenertaor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F5F1),
      body: StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            final currentUserId = user.uid;

            if (user.displayName == null || user.displayName!.isEmpty) {
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
                            gradient: LinearGradient(
                              colors: [Color(grad1), Color(grad2)],
                            ),
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

                              grad1 = 0xffFF6A88;
                              grad2 = 0xFFF94468;
                            });
                          },
                          child: reusablecustomavatar(
                            avater: avater,
                            avaterstate: avaterlist.first,

                            color1: 0xffFF6A88,
                            color2: 0xFFF94468,
                          ),
                        ),

                        //2
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              avater = avaterlist.second;
                              grad1 = 0xff84FAB0;
                              grad2 = 0xff8FD3F4;
                            });
                          },
                          child: reusablecustomavatar(
                            avater: avater,
                            avaterstate: avaterlist.second,

                            color1: 0xff84FAB0,
                            color2: 0xff8FD3F4,
                          ),
                        ),
                        //3
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              avater = avaterlist.third;
                              grad1 = 0xffA1C4FD;
                              grad2 = 0xffC2E9FB;
                            });
                          },
                          child: reusablecustomavatar(
                            avater: avater,
                            avaterstate: avaterlist.third,
                            color1: 0xffA1C4FD,
                            color2: 0xffC2E9FB,
                          ),
                        ),
                        //4
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              avater = avaterlist.fourth;
                              grad1 = 0xffF093FB;
                              grad2 = 0xffF5576C;
                            });
                          },
                          child: reusablecustomavatar(
                            avater: avater,
                            avaterstate: avaterlist.fourth,

                            color1: 0xffF093FB,
                            color2: 0xffF5576C,
                          ),
                        ),
                        //5
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              avater = avaterlist.fifth;
                              grad1 = 0xffFA709A;
                              grad2 = 0xffFEE140;
                            });
                          },
                          child: reusablecustomavatar(
                            avater: avater,
                            avaterstate: avaterlist.fifth,
                            color1: 0xffFA709A,
                            color2: 0xffFEE140,
                          ),
                        ),
                        //6
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              avater = avaterlist.sixth;
                              grad1 = 0xff4FACFE;
                              grad2 = 0xff00F2FE;
                            });
                          },
                          child: reusablecustomavatar(
                            avater: avater,
                            avaterstate: avaterlist.sixth,
                            color1: 0xff4FACFE,
                            color2: 0xff00F2FE,
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (c) => InboxScreen(id: currentUserId),
                              ),
                            );
                          });
                        }),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasData && snapshot.data!.displayName != null) {
              return InboxScreen(id: config);
            }
          }
          return RegistrationScreen();
        },
      ),
    );
  }
}
