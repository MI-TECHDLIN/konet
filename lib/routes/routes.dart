import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/screens/messaging/inbox_screen.dart';
import 'package:konet/screens/auth/authenication_screen.dart';
import 'package:konet/screens/onboadring/registration_screen.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  //TODO: later user of a validatpr checker for users
  //   Future<void> checkuserlogin_stats() async {

  //  var validator=  await FirebaseAuth.instance.currentUser!.reload();

  //   if(validator
  //   !=null){

  //   }
  //   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F5F1),
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
