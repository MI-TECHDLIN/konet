import 'package:flutter/material.dart';
import 'package:konet/routes/routes.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Routes());
  }
}
