import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:konet/screens/messaging/widget/inbox_card.dart';
import 'package:konet/screens/messaging/widget/pineed_widget.dart';
import 'package:konet/screens/messaging/widget/thread_selector.dart';

class InboxScreen extends StatefulWidget {
  InboxScreen({required this.id});
  final String id;
  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  //variables
  List data = [];
  int color1 = 0xffF093FB;
  int color2 = 0xFF57F5A9;

  String intColorConverter(int decimalValue) {
    '''
a function that recives decmial values and converts to hexcodes 
''';
    if (decimalValue == 0) return '0';

    String hexResult = '';

    while (decimalValue > 0) {
      int remainder = decimalValue % 16;

      String hexDigit = switch (remainder) {
        10 => 'A',
        11 => 'B',
        12 => 'C',
        13 => 'D',
        14 => 'E',
        15 => 'F',
        _ => remainder.toString(), // For 0-9, just keep the number as a string
      };

      hexResult = hexDigit + hexResult;

      decimalValue = decimalValue ~/ 16;
    }

    return hexResult;
  }

  final _accountinstance = FirebaseFirestore.instance;
  Future<void> _profileresponse() async {
    var _resonse = _accountinstance
        .collection('users')
        .doc(widget.id)
        .collection('details')
        .snapshots()
        .map((snap) => snap.docs);

    await for (List<QueryDocumentSnapshot>? docs in _resonse) {
      print('new update');

      for (final doc in docs!) {
        final datum = doc.data() as Map<String, dynamic>;
        ;

        var color = datum['profile-color'];
        setState(() {
          color1 = color[0];
          color2 = color[1];
        });

        print('omo see oo  ${int.parse(intColorConverter(color1), radix: 16)}');
      }
    }
  }

  // Future<void> get_allusers() async {
  //   final users = _accountinstance
  //       .collection('messages')
  //       .snapshots()
  //       .map((snap) => snap.docs);

  //   await for (List<QueryDocumentSnapshot<Map<String, dynamic>>> user
  //       in users) {
  //     print('new-update');

  //     for (var doc in user) {
  //       final datum = doc.data();
  //       print('Message ID: ${doc.id}, Content: ${datum['text']}');
  //       data.add(datum['sender']);
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileresponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F5F1),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color(0xffF6F5F1),
        title: Container(
          width: 90,
          margin: EdgeInsets.only(left: 10),
          child: Text(
            'konet.',
            style: TextStyle(
              fontFamily: 'InstrumentSerif',
              fontSize: 42,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 30),
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: LinearGradient(
                    colors: [
                      Color(
                        0xff + int.parse(intColorConverter(color1), radix: 16),
                      ),
                      Color(
                        0xff + int.parse(intColorConverter(color2), radix: 16),
                      ),
                    ],
                  ),
                ),
                child: Image.asset('assets/image/profile.png', scale: 2.0),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            //search tab v1
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
              height: 50,

              width: 327,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Icon(Icons.search, color: Color(0xff9CA3AF)),
                  ),

                  SizedBox(width: 10),
                  Text('search', style: TextStyle(color: Color(0xff9CA3AF))),
                ],
              ),
            ),

            thread_selector(),

            //pinned widget
            Container(
              margin: EdgeInsets.fromLTRB(40, 14, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PINNED',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff9CA3AF),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Row(
                      children: [
                        pinned_widget(
                          text: 'sarah',
                          grad1: 0xffFF6A88,
                          grad2: 0xffFF9A8B,
                        ),

                        pinned_widget(
                          text: 'marcus',
                          grad1: 0xff84FAB0,
                          grad2: 0xff8FD3F4,
                        ),

                        pinned_widget(
                          text: 'elena',
                          grad1: 0xffA1C4FD,
                          grad2: 0xffC2E9FB,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //chat_home;
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 500,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Color(0xffFFFFFF),
              ),
              width: 376,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    inbox_card(
                      grad1: 0xffF093FB,
                      grad2: 0xffF5576C,
                      label: 'JD',
                      displayname: 'James',
                      newthread: 'Check out the new designs!',
                    ),

                    inbox_card(
                      grad1: 0xffFA709A,
                      grad2: 0xffFEE140,
                      label: 'AK',
                      displayname: 'Aisha',
                      newthread: 'Sounds good, see you then!',
                    ),
                    inbox_card(
                      grad1: 0xff4FACFE,
                      grad2: 0xff00F2FE,

                      label: 'RB',
                      displayname: 'Riley',
                      newthread: 'Sounds good, see you then!',
                    ),

                    inbox_card(
                      grad1: 0xff667EEA,

                      grad2: 0xff764BA2,
                      label: 'TP',
                      displayname: 'Team',
                      newthread: 'Meeting scheduled for 3 PM.',
                    ),

                    inbox_card(
                      grad1: 0xff667EEA,

                      grad2: 0xff764BA2,
                      label: 'TP',
                      displayname: 'Team',
                      newthread: 'Meeting scheduled for 3 PM.',
                    ),

                    inbox_card(
                      grad1: 0xff667EEA,

                      grad2: 0xff764BA2,
                      label: 'TP',
                      displayname: 'Team',
                      newthread: 'Meeting scheduled for 3 PM.',
                    ),

                    inbox_card(
                      grad1: 0xff667EEA,

                      grad2: 0xff764BA2,
                      label: 'TP',
                      displayname: 'Team',
                      newthread: 'Meeting scheduled for 3 PM.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
