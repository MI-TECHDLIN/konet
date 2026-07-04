import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final _authinbox = FirebaseAuth.instance;
  final _cloudmessage = FirebaseFirestore.instance;
  String? _displayname = 'User 01';

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? _response;
  //functions
  Stream<String?> _getDisplayNameStream() {
    return _authinbox.userChanges().map((User? user) {
      if (user == null) {
        print('User is currently signed out.');
        return null;
      }

      _displayname = user.displayName;
      print('This is the display name: $_displayname');
      return _displayname;
    });
  }

  Future<void> sendMEssage(String nuggets) async {
    await _cloudmessage.collection('messages').add({
      'sender': _authinbox.currentUser!.email,
      'text': nuggets,
    });
  }

  Future<void> _messageResponse() async {
    _response = _cloudmessage
        .collection('messages')
        .snapshots()
        .map((snap) => snap.docs);

    await for (List<QueryDocumentSnapshot> docs in _response!) {
      print('New Update');

      // This loops through each individual document in the current list
      for (final doc in docs) {
        final data = doc.data() as Map<String, dynamic>;
        print('Message ID: ${doc.id}, Content: ${data['text']}');
      }
    }
  }

  String? messagetext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendMEssage('uba kosi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F5F1),

      appBar: AppBar(
        elevation: 5,
        surfaceTintColor: Color.fromARGB(255, 219, 218, 214),
        backgroundColor: Color(0xffF6F5F1),

        // shadowColor: Color(0xffF6F5F1),
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
                Text(
                  _displayname!,
                  style: TextStyle(fontWeight: FontWeight.w700),
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
        child: StreamBuilder<String?>(
          stream: _getDisplayNameStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                itemBuilder: (ctx, ind) {
                  return Container(child: Text(''));
                },
                itemCount: _response!.length as int,
              );
            } else {
              return const Text('No Display Name Set');
            }
          },
        ),
      ),
    );
  }
}
