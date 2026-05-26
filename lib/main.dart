import 'package:flutter/material.dart';
import 'package:konet/screens/chat_screen.dart';
import 'package:konet/screens/login_screen.dart';
import 'package:konet/screens/registration_screen.dart';
import 'package:konet/screens/welcome_screen.dart';

void main() {
  runApp(const KonetApp());
}

class KonetApp extends StatelessWidget {
  const KonetApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
