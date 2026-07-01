import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late final User? _user = _auth.currentUser;

  late String? _displayname = _user!.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('$_displayname:this is display name')),
    );
  }
}
