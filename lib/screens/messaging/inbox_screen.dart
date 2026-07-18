import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:konet/screens/messaging/widget/inbox_card.dart';
import 'package:konet/screens/messaging/widget/modal_sheet.dart';
import 'package:konet/screens/messaging/widget/pineed_widget.dart';
import 'package:konet/screens/messaging/widget/thread_selector.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key, required this.id});
  final String id;
  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  //variables
  List data = [];
  int color1 = 0xffF093FB;
  int color2 = 0xFF57F5A9;

  //uservariables
  final String _displayname = 'user01';
  final int _color1 = 0xffF093FB;
  final int _color2 = 0xFF57F5A9;

  final List<Map<String, dynamic>> users = [];

  // custom Functions
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

  final _accountinstance = FirebaseFirestore.instance.collection('database');
  Future<void> _profileresponse() async {
    '''
this function in to get personal inform about your profile
''';

    try {
      var resonse = _accountinstance
          .doc('123')
          .collection('users')
          .doc(widget.id)
          .collection('details')
          .snapshots()
          .map((snap) => snap.docs);

      await for (List<QueryDocumentSnapshot>? docs in resonse) {
        if (!mounted) return;
        print('new update');

        for (final doc in docs!) {
          final datum = doc.data() as Map<String, dynamic>;

          var color = datum['profile-color'];
          setState(() {
            color1 = color[0];
            color2 = color[1];
          });

          print(
            'omo see oo  ${int.parse(intColorConverter(color1), radix: 16)}',
          );
        }
      }
    } catch (e) {
      print('error:${e.toString()}');
    }
  }

  Future<void> getfolks() async {
    '''
this function is used to stream  folks and stream and add them to a local var
''';

    var folks = _accountinstance
        .doc('123')
        .collection('users')
        .doc(widget.id)
        .collection('folks')
        .snapshots()
        .map((snap) => snap.docs);

    await for (var folk in folks) {
      print('updated folks!');

      for (var data in folk) {
        print('lol see ur friend${data.data()}');

        setState(() {
          users.add(data.data());
          print('this is ur friends');
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement iniRtState
    super.initState();
    _profileresponse();
    getfolks();
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
      body: Column(
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
                  margin: EdgeInsets.only(left: 14),
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
            margin: EdgeInsets.fromLTRB(50, 14, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                Row(
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
              ],
            ),
          ),

          //chat_home;
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 30),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Color(0xffFFFFFF),
              ),
              width: 376,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (ctx, index) {
                  //streaming other users with stream
                  //modal userdatas for other users
                  Map<String, dynamic> eprofile = users[index]['data'];
                  String dataid = users[index]['docid'];

                  String username = eprofile['username'];
                  String email = eprofile['email'];
                  List colors = eprofile['profile-color'];
                  int fColor = int.parse(
                    intColorConverter(colors[0]),
                    radix: 16,
                  );
                  int sColor = int.parse(
                    intColorConverter(colors[1]),
                    radix: 16,
                  );

                  print('this is the datas $data');
                  return inbox_card(
                    userid: 'jj',
                    grad1: fColor,
                    grad2: sColor,
                    label: 'JB',
                    displayname: username,
                    newthread: 'ballo',
                  );
                },
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: FloatingActionButton(
          backgroundColor: Color(0xff4F46E5),

          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (ctx) {
                return modalsheet(
                  userid: widget.id,
                  store: users,
                  getusers: () => getfolks(),
                );
              },
            );
          },
          child: Image.asset('assets/image/add.png'),
        ),
      ),
    );
  }
}
