import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:konet/screens/messaging/widget/message_card.dart';

class InboxScreen extends StatefulWidget {
  InboxScreen({required this.id});

  final String id;
  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  //variables
  final _textcontorlller = TextEditingController();
  final _authinbox = FirebaseAuth.instance;
  final _cloudmessage = FirebaseFirestore.instance.collection('users');
  String? get _currentemail => _authinbox.currentUser?.email;
  String? _displayname = 'User 01';
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? _response;
  int? _responseint;
  List<Map<String, dynamic>> data = [];

  //functions
  Stream<String?> _getDisplayNameStream() {
    return _authinbox.userChanges().map((User? user) {
      if (user!.displayName != null) {
        _displayname = user.displayName;
        return _displayname;
      } else {
        return null;
      }
    });
  }

  Widget get _emptystate => Container(
    alignment: Alignment.center,
    height: 708,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/image/emptystateasset.png'),
        SizedBox(height: 12),
        Text(
          'No messages yet',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 205,
          child: Text(
            'Say hi to $_displayname! Be the first to start the conversation',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Color(0xff8E8E93)),
          ),
        ),
      ],
    ),
  );
  Widget _messagestate(int index) => _currentemail == data[index]['sender']
      ? MessageCard(
          0,
          24,
          id: 'lol',
          messagestring: data[index]['text'],
          calcheight: data[index]['text'],
          position: EdgeInsets.fromLTRB(130.61, 0, 16, 10),
          color: 0xFF4E45F2,

          textcolor: Colors.white,
        )
      : MessageCard(
          24,
          0,
          id: 'lol',
          messagestring: data[index]['text'],
          calcheight: data[index]['text'],
          position: EdgeInsets.fromLTRB(16, 0, 130.61, 10),
          color: 0xffEFEEE9,
          textcolor: Colors.black,
        );

  Future<void> sendMEssage(String nuggets) async {
    await _cloudmessage.doc(widget.id).collection('messages').add({
      'sender': _authinbox.currentUser!.email,
      'text': nuggets,
    });
  }

  // TODO: modify functions in a way it getts message based on user id not a globsl fetching
  Future<void> _messageResponse() async {
    _response = _cloudmessage
        .doc(widget.id)
        .collection('messages')
        .snapshots()
        .map((snap) => snap.docs);

    '''
message response is using a stream sequence 
to get snapshots from firestore for updates and to get documents stored

''';

    await for (List<QueryDocumentSnapshot> docs in _response!) {
      print('New Update');

      //length for all response
      _responseint = docs.length;

      data.clear();

      // This loops through each individual document in the current list]
      for (final doc in docs) {
        final datum = doc.data() as Map<String, dynamic>;
        print('Message ID: ${doc.id}, Content: ${datum['text']}');
        data.add(datum);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getDisplayNameStream();
    _messageResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F5F1),

      appBar: AppBar(
        elevation: 5,
        surfaceTintColor: Color.fromARGB(255, 219, 218, 214),
        backgroundColor: Color(0xffF6F5F1), // shadowColor: Color(0xffF6F5F1),

        toolbarHeight: 70,
        leading: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(left: 20),
          child: IconButton(
            //TODO: make this button active ones i build the home screen
            onPressed: null,
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 21),
          ),
        ),

        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 6),
              padding: EdgeInsets.all(8.0),

              alignment: Alignment.center,
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                gradient: LinearGradient(
                  colors: [Color(0xff84FAB0), Color(0xff8FD3F4)],
                ),
              ),
              child: Image.asset('assets/image/profile.png', scale: 2.0),
            ),
            SizedBox(width: 13),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: _getDisplayNameStream(),
                  builder: (context, asyncSnapshot) {
                    if (_authinbox.currentUser!.displayName != null) {
                      return Text(
                        _displayname!,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      );
                    } else {
                      return Text(
                        _displayname!,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      );
                    }
                  },
                ),
                Text(
                  'online',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xff9CA3AF),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot?>(
                stream: _cloudmessage
                    .doc(widget.id)
                    .collection('messages')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        height: 708,

                        child: Align(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else if (snapshot.data!.docs.isNotEmpty) {
                    return SizedBox(
                      height: 708,
                      child: ListView.builder(
                        itemBuilder: (ctx, ind) {
                          return
                          //message sorting by email
                          _messagestate(ind);
                        },
                        itemCount: _responseint,
                      ),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return _emptystate;
                  } else {
                    return Text('no data here');
                  }
                },
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: 343,
                height: 80,
                child: TextField(
                  controller: _textcontorlller,
                  onSubmitted: (text) {
                    sendMEssage(_textcontorlller.text);
                    _textcontorlller.clear();
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hint: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: const Text(
                            'message',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.emoji_emotions_outlined,
                            color: Color(0xff9CA3AF),
                          ),
                        ),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
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
