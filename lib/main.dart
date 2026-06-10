import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konet/routes.dart';
import 'package:konet/screens/chat_screen.dart';
import 'package:konet/screens/login_screen.dart';
import 'package:konet/screens/registration_screen.dart';
import 'package:konet/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseAuth.instance.userChanges().listen((User? user) {
  //   if (user == null) {
  //     print('this user does not havea acoount');
  //   } else {
  //     print('Loggged in');
  //   }
  // });
  runApp(KonetApp());
}

class KonetApp extends StatefulWidget {
  const KonetApp({super.key});

  @override
  State<KonetApp> createState() => _KonetAppState();
}

class _KonetAppState extends State<KonetApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Routes());
  }
}
