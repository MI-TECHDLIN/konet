import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:konet/screens/messaging/widget/inbox_card.dart';
import 'package:konet/screens/messaging/widget/modal_sheet.dart';
import 'package:konet/screens/messaging/widget/pineed_widget.dart';
import 'package:konet/screens/messaging/widget/thread_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konet/constant/function.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});
  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  //variables
  var linkid = '';

  List<Map<String, dynamic>> pinnedchats = [];
  List<Map<String, dynamic>> filteredUsers = [];

  List data = [];
  int color1 = 0xffF093FB;
  int color2 = 0xFF57F5A9;
  final SearchController _searchcontroller = SearchController();
  //uservariables
  final String _displayname = 'user01';
  final int _color1 = 0xffF093FB;
  final int _color2 = 0xFF57F5A9;

  final List<Map<String, dynamic>> users = [];

  // custom Functions

  Future<String?> getId() async {
    '''
custom functions to get users id from localsotrage
''';
    final SharedPreferences preference = await SharedPreferences.getInstance();

    setState(() {
      linkid = preference.getString('id')!;
    });

    print('this is linkid of u $linkid');
    _profileresponse();
    getfolks();

    return linkid;
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
          .doc(linkid)
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

  void pinnedchat() {
    '''
this function sort pinnedchats from the the usersdirectory
''';
    pinnedchats = users.where((user) {
      return user['userdata']['pinid'] == true;
    }).toList();

    print('these are pinned chats $pinnedchats');
  }

  Future<void> getfolks() async {
    '''
this function is used to stream  folks and stream and add them to a local var
''';

    var folks = _accountinstance
        .doc('123')
        .collection('users')
        .doc(linkid)
        .collection('folks')
        .snapshots()
        .map((snap) => snap.docs);

    await for (var folk in folks) {
      print('updated folks!');
      users.clear();

      for (var data in folk) {
        setState(() {
          users.add({'docid': data.id, 'userdata': data.data()});

          print('new users added $users');
          filteredUsers = List.from(users);
          pinnedchat();
        });
      }
    }
  }

  void filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = List.from(users);
      } else {
        filteredUsers = users.where((user) {
          final username = user['data']['username'].toLowerCase();

          return username.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement iniRtState
    super.initState();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 15, 24, 10),
            child: SearchAnchor.bar(
              searchController: _searchcontroller,
              barHintText: 'Search people...',
              barBackgroundColor: WidgetStateProperty.all(Colors.white),
              barElevation: WidgetStateProperty.all(0),
              barShape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              suggestionsBuilder: (context, controller) {
                final query = controller.text.toLowerCase();

                final results = users.where((user) {
                  final username = (user['data']['username'] as String)
                      .toLowerCase();

                  return username.contains(query);
                });

                return results.map((user) {
                  final profile = user['data'];

                  return ListTile(
                    title: Text(profile['username']),
                    subtitle: Text(profile['email']),
                    onTap: () {
                      controller.closeView(profile['username']);

                      // Open chat here if you want
                    },
                  );
                });
              },
            ),
          ),

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
                  children: pinnedchats.map((user) {
                    final profile = user['userdata']['data'];

                    return pinned_widget(
                      text: profile['username'],
                      grad1: int.parse(
                        intColorConverter(profile['profile-color'][0]),
                        radix: 16,
                      ),
                      grad2: int.parse(
                        intColorConverter(profile['profile-color'][1]),
                        radix: 16,
                      ),
                    );
                  }).toList(),
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
              child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _accountinstance
                      .doc('123')
                      .collection('users')
                      .doc(linkid)
                      .collection('folks')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: ((tontext, index) {
                          var refrenceid = users[index]['docid'];
                          //streaming other users with stream
                          //modal userdatas for other users
                          final _data = users[index]['userdata'];

                          final profile = _data['data'];
                          String userid = profile['userid'];
                          String messgaeid = _data['messageid'];
                          String username = profile['username'];
                          bool pinid = _data['pinid'];

                          String abbr = username.substring(0, 2).toUpperCase();
                          String email = profile['email'];
                          List colors = profile['profile-color'];
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
                            refrenceid: refrenceid,
                            pinid: pinid,
                            messageid: messgaeid,
                            s_userid: linkid,
                            r_userid: userid,
                            grad1: fColor,
                            grad2: sColor,
                            label: abbr,
                            displayname: username,
                            newthread: 'new chat',
                          );
                        }),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Center(
                      child: Text(
                        'No message yet add a friend to start chatting',
                      ),
                    );
                  },
                ),
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
                  userid: linkid,
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
