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

  Stream<String?> getDisplayNameStream() {
    return _authinbox.userChanges().map((User? user) {
      if (user == null) {
        print('User is currently signed out.');
        return null;
      }

      final String? displayname = user.displayName;
      print('This is the display name: $displayname');
      return displayname;
    });
  }

  sendMEssage(String nuggets) async {
    await _cloudmessage.collection('messages').add({
      'sender': _authinbox.currentUser!.email,
      'text': nuggets,
    });
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
      appBar: AppBar(
        leading: IconButton(onPressed: null, icon: Icon(Icons.arrow_back_ios)),

        title: Container(
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: LinearGradient(
                    colors: [Color(0xff84FAB0), Color(0xff8FD3F4)],
                  ),
                ),
                child: Image.asset('assets/image/profile.png', scale: 2.0),
              ),
              Column(
                children: [
                  Text('sarah', style: TextStyle(fontWeight: FontWeight.w500)),
                  Text('online'),
                ],
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: StreamBuilder<String?>(
          stream: getDisplayNameStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasData && snapshot.data != null) {
              return Column(children: []);
            } else {
              return const Text('No Display Name Set');
            }
          },
        ),
      ),
    );
  }
}
