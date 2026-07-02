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
    sendMEssage('do you have money');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<String?>(
          stream: getDisplayNameStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasData && snapshot.data != null) {
              return Text('Welcome, ${snapshot.data}');
            } else {
              return const Text('No Display Name Set');
            }
          },
        ),
      ),
    );
  }
}
