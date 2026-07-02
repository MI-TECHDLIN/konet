import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

Stream<String?> getDisplayNameStream() {
  return FirebaseAuth.instance.userChanges().map((User? user) {
    if (user == null) {
      print('User is currently signed out.');
      return null;
    }

    final String? displayname = user.displayName;
    print('This is the display name: $displayname');
    return displayname;
  });
}

class _InboxScreenState extends State<InboxScreen> {
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
