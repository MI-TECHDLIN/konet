import 'package:flutter/material.dart';
import 'package:konet/screens/chat_screen.dart';
import 'package:konet/screens/login_screen.dart';
import 'package:konet/screens/registration_screen.dart';
import 'package:konet/screens/welcome_screen.dart';

void main() {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.welcomeScreenId,
      routes: {
        WelcomeScreen.welcomeScreenId: (ctx) => WelcomeScreen(),
        RegistrationScreen.registrationScreenId: (ctx) => RegistrationScreen(),
        LoginScreen.loginId: (ctx) => LoginScreen(),
        ChatScreen.chatScreenId: (ctx) => ChatScreen(),
      },
    );
  }
}
