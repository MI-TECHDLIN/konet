import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class modalsheet extends StatefulWidget {
  const modalsheet({
    super.key,
    required this.userid,
    required this.store,
    required this.getusers,
  });
  final String userid;
  final List<Map<String, dynamic>> store;

  final VoidCallback getusers;
  @override
  State<modalsheet> createState() => _modalsheetState();
}

class _modalsheetState extends State<modalsheet> {
  bool saved = false;

  final _data = FirebaseFirestore.instance.collection('database');
  final TextEditingController useridstr = TextEditingController();
  //functions
  void copybiloard(BuildContext ctx) {
    '''
this function is callled to fetch usercode 
''';
    Clipboard.setData(
      ClipboardData(text: widget.userid),
    ).then((_) => print(widget.userid));
  }

  void shareoption() {
    '''
share option to different socials
''';
    Share.share(
      widget.userid,
      subject: 'share unique code to add friend ${widget.userid} ',
    );
  }

  Future<void> updateuser(Map<String, dynamic> user) async {
    '''
this function basically updtaes user to firestore straight before bumpting to local list
''';
    try {
      _data
          .doc('123')
          .collection('users')
          .doc(widget.userid)
          .collection('folks')
          .add(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> adduser(String userid) async {
    '''
  this basically add users to collection

  ''';
    try {
      final sendrequest = _data
          .doc('123')
          .collection('users')
          .doc(userid)
          .collection('details')
          .snapshots()
          .map((doc) => doc.docs);

      await for (var data in sendrequest) {
        //fetches modified data from dbs
        if (!mounted) return;

        print('newuuupdate');

        for (final singlet in data) {
          final datum = singlet.data();
          final docid = singlet.id;
          final userid = datum['userid'];
          final Map<String, dynamic> user = {'docid': docid, 'data': datum};

          setState(() {
            updateuser(user);

            widget.store.isEmpty ? saved = false : saved = true;
            saved == true ? Navigator.pop(context) : print('awaiting');
          });
          // for (int i = 0; i < widget.store.length; i++) {
          //   if (widget.store[i]['data']['userid'] == userid) {
          //     print('this user exist ${widget.store}');
          //   } else {
          //     print('this user added');
          //   }
          // }
        }
      }
    } catch (e) {
      print('erro:${e.toString()}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //modal  bottom sheet implemeneted for add users in custom collection
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: 460,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add a Friend',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
              ),
              SizedBox(height: 5),
              const Text(
                'Share your code or enter a friend\'s',
                style: TextStyle(color: Color(0xff6B7280)),
              ),
              GestureDetector(
                onTap: () => copybiloard(context),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(20),
                  height: 76,
                  width: 327,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Color(0xFFC8D3F7),
                  ),

                  child: Text(
                    widget.userid,
                    style: TextStyle(
                      fontSize: 26,

                      fontWeight: FontWeight.bold,
                      color: Color(0xff4F46E5),
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                child: Text(
                  'Tap to copy',
                  style: TextStyle(color: Color(0xff6B7280)),
                ),
              ),

              Container(
                margin: EdgeInsets.all(16),
                // alignment: Alignment.center,
                height: 52,
                width: 327,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xff4F46E5)),
                  ),
                  onPressed: () => shareoption(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/share.png'),
                      SizedBox(width: 5),
                      Text(
                        'Share my code',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 2),
                    height: 1,
                    width: 100,
                    color: Color(0xFF9E9E9E),
                  ),
                  Text('or'),
                  Container(
                    margin: EdgeInsets.only(left: 2),
                    height: 1,
                    width: 100,
                    color: Color(0xFF9E9E9E),
                  ),
                ],
              ),

              Center(
                child: Container(
                  //textfield   for sorting friends userid
                  margin: EdgeInsets.only(top: 25),
                  //
                  alignment: Alignment.center,
                  height: 65,
                  width: 320,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,

                        height: 40,
                        width: 220,
                        child: TextField(
                          controller: useridstr,
                          decoration: InputDecoration(
                            hint: Container(
                              height: 25,
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                'Enter friend\'s code',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff6B7280),
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 36,
                        width: 76,

                        child: ElevatedButton(
                          onPressed: () {
                            adduser(useridstr.text);
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: WidgetStatePropertyAll(
                              Color(0xff4F46E5),
                            ),
                          ),

                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
