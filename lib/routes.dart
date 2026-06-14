import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/screens/inbox_screen.dart';
import 'package:konet/screens/onboadring/registration_screen.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return RegistrationScreen();
          } else {
            return InboxScreen();
          }
        },
      ),
    );
  }
}
